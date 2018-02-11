# frozen_string_literal: true

class SubmissionCheckWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'high'

  def perform(submission_id)
    submission = Submission.find(submission_id)
    submission.run_tests
  end
end
