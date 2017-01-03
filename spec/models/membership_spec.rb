# frozen_string_literal: true
require 'rails_helper'

describe Membership, type: :model do
  it 'has a relation with users' do
    membership = build(:membership)
    user = create(:user)

    membership.user = user
    membership.save!

    expect(membership.user).to eq user
    expect(user.memberships).to eq [membership]
    expect(user.courses).to eq [membership.course]
  end

  it 'has a relation with courses' do
    membership = build(:membership)
    course = create(:course)

    membership.course = course
    membership.save!

    expect(membership.course).to eq course
    expect(course.memberships).to eq [membership]
    expect(course.users).to eq [membership.user]
  end

  it 'has roles' do
    membership = create(:membership, role: :instructor)
    expect(membership).to be_instructor
    expect(Membership.instructor).to eq [membership]
  end
end
