# frozen_string_literal: true

require 'rails_helper'

describe Team, type: :model do
  it 'has memberships' do
    team = create(:team)
    team.memberships = memberships = create_list(:membership, 3)

    expect(team.memberships).to match_array(memberships)
    memberships.each do |membership|
      expect(membership.teams).to eq [team]
      expect(membership.user.teams).to eq [team]
    end
  end

  it 'has submissions' do
    team = create(:team)
    Sidekiq::Testing.fake!
    team.submissions = submissions = create_list(:file_submission, 3)

    expect(team.submissions).to match_array(submissions)
    submissions.each do |submission|
      expect(submission.team).to eq team
    end
  end

  it 'has a repository owner' do
    team = create(:team)
    user = create(:user)

    team.repository_owner = user
    team.save!

    expect(team.reload.repository_owner).to eq user
  end
end
