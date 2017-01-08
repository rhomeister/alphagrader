# frozen_string_literal: true
class AuthorContributionTest < Test
  def run(submission)
    runner = Runner.new(submission).run
    AuthorContributionTestResult.new(status: runner.status,
                                     name: name,
                                     public: public)
  end

  Runner = Struct.new(:submission, :status) do
    def run
      self.status = if submission.team.memberships.sort == submission.contributors.sort
                      :success
                    else
                      :failure
                    end
      self
    end
  end
end
