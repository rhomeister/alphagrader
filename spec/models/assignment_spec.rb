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

  it 'has been uploaded by a user' do
    submission = create(:submission)
    user = create(:user)

    submission.uploaded_by = user
    submission.save!

    expect(submission.reload.uploaded_by).to eq user
  end

  it 'has been submitted by users' do
    submission = create(:submission)
    submission.authors = users = create_list(:user, 3)

    expect(submission.reload.authors).to match_array(users)
    expect(users.first.submissions).to eq [submission]
  end
end
