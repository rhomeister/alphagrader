# frozen_string_literal: true
class Submission < ApplicationRecord
  belongs_to :assignment
  belongs_to :uploaded_by, class_name: 'User'
  belongs_to :team, inverse_of: :submissions

  enum status: [:queued, :running, :success, :failure]
  has_many :test_results, dependent: :destroy
  has_many :contributions, inverse_of: :submission, dependent: :destroy
  has_many :contributors, through: :contributions, class_name: 'Membership', source: :membership

  before_create do
    self.status ||= :queued
  end

  after_commit on: :create do
    SubmissionCheckWorker.perform_async(id)
  end

  after_save do
    next unless checks_completed?
    notify_users
  end

  def detect_status
    self.status = test_results.reload.all?(&:success?) ? :success : :failure
  end

  def run_tests
    test_results.destroy_all
    download
    inject_runfile_if_not_exists
    run_pre_test_checks
    self.status = :running
    save!
    run_user_tests
    detect_status
    save!
  ensure
    cleanup
  end

  def checks_completed?
    !queued? && !running?
  end

  def cleanup
    FileUtils.rm_r tempdir
  end

  def tempdir
    @tempdir ||= Dir.mktmpdir
  end

  private

  def inject_runfile_if_not_exists
    return if language.blank?
    return if File.exist?("#{tempdir}/run")
    file = LanguageSpecificRunfile.find(language)
    FileUtils.copy_file(file, File.join(tempdir, 'run'))
  end

  def notify_users
    return unless team
    url = Rails.application.routes.url_helpers.assignment_submission_path(assignment, self)
    team.users.each do |user|
      ActionCable.server.broadcast "submissions_#{user.id}",
                                   title: 'Build completed', body: "Result: #{status}", url: url
    end
  end

  def run_pre_test_checks
  end

  def run_user_tests
    assignment.tests.each do |test|
      test_result = test.run(self)
      test_result.submission = self
      test_result.save!
    end
  end
end
