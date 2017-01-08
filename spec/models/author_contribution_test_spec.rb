# frozen_string_literal: true
require 'rails_helper'

describe AuthorContributionTest, type: :model do
  context 'run' do
    it 'returns success if all team members are authors' do
      user = create(:user)
      team = create(:team, memberships: [create(:membership, user: user)])
      submission = create(:submission, team: team)
      submission.contributors = team.memberships
      test = create(:author_contribution_test)
      result = test.run(submission)

      expect(result).to be_success
    end

    it 'returns failure if there are team members who are not authors' do
      user = create(:user)
      team = create(:team, memberships: [create(:membership, user: user)])
      submission = create(:submission, team: team)
      submission.contributors.clear

      test = create(:author_contribution_test)
      result = test.run(submission)

      expect(result).to be_failure
    end
  end
end
