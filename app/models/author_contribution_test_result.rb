# frozen_string_literal: true

class AuthorContributionTestResult < TestResult
  def test_type
    AuthorContributionTest
  end

  def missing_contributers
    submission.team.memberships - submission.contributors
  end
end
