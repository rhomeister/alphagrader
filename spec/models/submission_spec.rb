# frozen_string_literal: true
require 'rails_helper'

describe Submission, type: :model do
  it 'has been uploaded by a user' do
    submission = create(:submission)
    user = create(:user)

    submission.uploaded_by = user
    submission.save!

    expect(submission.reload.uploaded_by).to eq user
  end

  it 'has contributions' do
    submission = create(:submission)
    submission.contributions = contributions = create_list(:contribution, 3)

    expect(submission.reload.contributions).to match_array(contributions)
    expect(submission.reload.contributors).to match_array(contributions.map(&:membership))
    contributions.each do |contribution|
      expect(contribution.submission).to eq submission
      expect(contribution.membership.submissions).to eq [submission]
    end
  end

  it 'has test results' do
    submission = create(:submission)
    submission.test_results = results = create_list(:test_result, 3)

    expect(submission.reload.test_results).to match_array(results)
    results.each do |result|
      expect(result.submission).to eq submission
    end
  end
end
