# frozen_string_literal: true
require 'rails_helper'

describe Assignment, type: :model do
  it 'has submissions' do
    assignment = create(:assignment)
    submission = create(:submission)
    assignment.submissions << submission

    expect(submission.reload.assignment).to eq assignment
    expect(assignment.reload.submissions).to eq [submission]
  end

  it 'has tests' do
    assignment = create(:assignment)
    test = create(:test)
    assignment.tests << test

    expect(test.reload.assignment).to eq assignment
    expect(assignment.reload.tests).to eq [test]
  end
end
