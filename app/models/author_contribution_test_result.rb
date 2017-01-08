# frozen_string_literal: true
class AuthorContributionTestResult < TestResult
  def test_type
    AuthorContributionTest
  end

  def missing_contributers
    submission.team.users - submission.authors
  end
end
