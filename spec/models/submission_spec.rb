# frozen_string_literal: true

require 'rails_helper'

describe Submission, type: :model do
  it 'has been uploaded by a user' do
    Sidekiq::Testing.fake!
    submission = create(:submission)
    user = create(:user)

    submission.uploaded_by = user
    submission.save!

    expect(submission.reload.uploaded_by).to eq user
  end

  it 'has contributions' do
    Sidekiq::Testing.fake!
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
    Sidekiq::Testing.fake!
    submission = create(:submission)
    submission.test_results = results = create_list(:test_result, 3)

    expect(submission.reload.test_results).to match_array(results)
    results.each do |result|
      expect(result.submission).to eq submission
    end
  end

  it 'can be exported to csv' do
    travel_to Time.zone.local(2022, 1, 1) # '2022-01-01'
    assignment = create(:assignment)
    assignment.tests << create(:expected_output_test)

    user = create(:user, name: 'Ruben')
    submission = build(:file_submission, assignment: assignment, uploaded_by: user)
    submission.file = File.new('spec/fixtures/dummy_submissions/correct.zip')
    submission.save!

    expect(submission.reload.status).to eq 'success'

    expected_csv = <<~EXPECTED
      id,uploaded_by_name,created_at,updated_at,test_results_count,successful_test_results_count,language,status
      #{submission.id},Ruben,2022-01-01 00:00:00 UTC,2022-01-01 00:00:00 UTC,1,1,,success
    EXPECTED

    expect(Submission.to_csv).to eq expected_csv
  end
end
