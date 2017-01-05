class SubmissionCheckJob
  @queue = :submission_check

  def self.perform(submission_id)
    submission = Submission.find(submission_id)
    submission.run_tests
  end
end
