# frozen_string_literal: true

class Submission < ApplicationRecord
  belongs_to :assignment
  belongs_to :uploaded_by, class_name: 'User'
  belongs_to :team, inverse_of: :submissions

  enum status: %i[queued running success failure]
  has_many :test_results, dependent: :destroy
  has_many :contributions, inverse_of: :submission, dependent: :destroy
  has_many :contributors, through: :contributions, class_name: 'Membership', source: :membership

  before_create do
    self.status ||= :queued
  end

  def self.to_csv
    attributes = %w[id uploaded_by_id created_at updated_at test_results_count successful_test_results_count language status]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |submission|
        csv << submission.attributes.values_at(*attributes)
      end
    end
  end

  after_commit on: :create do
    SubmissionCheckWorker.perform_async(id)
  end

  after_save do
    next unless checks_completed?

    notify_users
  end

  def successful_test_results_count
    value = self[:successful_test_results_count]
    return value if value

    self.successful_test_results_count = test_results.where(status: %w[success skipped]).count
    save
    successful_test_results_count
  end

  def detect_status
    self.status = test_results.reload.all?(&:success_or_skipped?) ? :success : :failure
  end

  # Whether a submission has automatically detectable contributors. Default
  # implementation that can be overridden by subclasses
  def detectable_contributors?
    true
  end

  def download; end

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

  def rerun_tests
    SubmissionCheckWorker.perform_async(id)
  end

  private

  def inject_runfile_if_not_exists
    return if language.blank?
    return if File.exist?("#{tempdir}/run")

    file = LanguageSpecificRunfile.find(language)
    FileUtils.copy_file(file, File.join(tempdir, 'run'))
  end

  def notify_users
    # return unless team
    # url = Rails.application.routes.url_helpers.assignment_submission_path(assignment, self)
    # team.users.each do |user|
    # ActionCable.server.broadcast "submissions_#{user.id}",
    # title: 'Build completed', body: "Result: #{status}", url: url
    # end
  end

  def run_pre_test_checks; end

  def run_user_tests
    assignment.tests.each do |test|
      test_result = test.run(self)
      test_result.submission = self
      test_result.save!
    end
  end
end
