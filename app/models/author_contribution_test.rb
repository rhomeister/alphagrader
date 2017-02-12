# frozen_string_literal: true
class AuthorContributionTest < Test
  def self.description
    [:author_contribution_test, {
      name: AuthorContributionTest.model_name.human,
      description: 'Checks whether all team members have made a commit.',
      class: AuthorContributionTest
    }]
  end

  def self.detailed_description
    description.last.fetch(:description)
  end

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
