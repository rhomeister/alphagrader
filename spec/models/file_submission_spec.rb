# frozen_string_literal: true
require 'rails_helper'

describe FileSubmission, type: :model do
  it 'downloads and unzips the file before running tests' do
    Resque.inline = true
    assignment = create(:assignment)
    assignment.tests << create(:expected_output_test)

    submission = build(:file_submission, assignment: assignment)
    submission.file = File.new('spec/fixtures/dummy_submissions/correct.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'

    Resque.inline = false
  end
end
