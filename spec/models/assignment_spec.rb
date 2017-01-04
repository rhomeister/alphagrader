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
end
