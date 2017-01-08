# frozen_string_literal: true
class Submission < ApplicationRecord
  belongs_to :assignment
  belongs_to :uploaded_by, class_name: 'User'
  belongs_to :team, inverse_of: :submissions

  enum status: [:queued, :running, :success, :failure]
  has_many :test_results, dependent: :destroy
  has_many :contributions, inverse_of: :submission
  has_many :contributors, through: :contributions, class_name: 'Membership', source: :membership

  before_create do
    self.status ||= :queued
  end

  after_create do
    Resque.enqueue(SubmissionCheckJob, id)
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
end
