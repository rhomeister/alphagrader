# frozen_string_literal: true
require 'rails_helper'

describe FileSubmission, type: :model do
  let(:assignment) do
    assignment = create(:assignment)
    assignment.tests << create(:expected_output_test,
                               program_input: "1\n1",
                               expected_program_output: '2')

    assignment
  end

  it 'works with C' do
    submission = build(:file_submission, assignment: assignment, language: 'c')
    submission.file = File.new('spec/fixtures/language_support_submissions/c.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'
  end

  it 'works with C++' do
    submission = build(:file_submission, assignment: assignment, language: 'cplus')
    submission.file = File.new('spec/fixtures/language_support_submissions/cpp.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'
  end

  it 'works with Ruby' do
    submission = build(:file_submission, assignment: assignment, language: 'ruby')
    submission.file = File.new('spec/fixtures/language_support_submissions/ruby.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'
  end

  it 'works with Python' do
    submission = build(:file_submission, assignment: assignment, language: 'python')
    submission.file = File.new('spec/fixtures/language_support_submissions/py.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'
  end

  it 'works with Java' do
    submission = build(:file_submission, assignment: assignment, language: 'java')
    submission.file = File.new('spec/fixtures/language_support_submissions/java.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'
  end

  it 'works with Javascript' do
    submission = build(:file_submission, assignment: assignment, language: 'javascript')
    submission.file = File.new('spec/fixtures/language_support_submissions/js.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'
  end

  it 'works with Python 3.6' do
    submission = build(:file_submission, assignment: assignment)
    submission.file = File.new('spec/fixtures/language_support_submissions/python36.zip')
    submission.save!
    expect(submission.reload.status).to eq 'success'
  end
end
