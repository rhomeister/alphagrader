# frozen_string_literal: true

require 'rails_helper'

describe FileSubmission, type: :model do
  it 'downloads and unzips the file before running tests' do
    assignment = create(:assignment)
    assignment.tests << create(:expected_output_test)

    submission = build(:file_submission, assignment: assignment)
    submission.file = File.new('spec/fixtures/dummy_submissions/correct.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'
  end

  it 'injects the run file if its missing and a programming language has been chosen' do
    assignment = create(:assignment)
    assignment.tests << create(:expected_output_test)

    submission = build(:file_submission, assignment: assignment, language: 'ruby')
    submission.file = File.new('spec/fixtures/dummy_submissions/correct_without_runfile.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'
  end

  it 'does not overwrite the run file submitted by the user' do
    assignment = create(:assignment)
    assignment.tests << create(:expected_output_test)

    submission = build(:file_submission, assignment: assignment, language: 'cplus')
    submission.file = File.new('spec/fixtures/dummy_submissions/correct.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'
  end
end
