# frozen_string_literal: true
require 'rails_helper'

describe Ability, type: :model do
  context 'courses' do
    it 'cannot read the course without being member' do
      ability = Ability.new(create(:user))
      course = create(:course)

      expect(ability.can?(:read, course)).to be false
    end

    it 'can read the course if member' do
      ability = Ability.new(user = create(:user))
      course = create(:course)
      create(:membership, user: user, course: course)

      expect(ability.can?(:read, course)).to be true
    end

    it 'can edit the course if instructor' do
      ability = Ability.new(user = create(:user))
      course = create(:course)
      create(:membership, user: user, course: course, role: :instructor)

      expect(ability.can?(:edit, course)).to be true
    end
  end

  context 'assignment' do
    it 'cannot read the assignment without being member' do
      ability = Ability.new(create(:user))
      assignment = create(:assignment)

      expect(ability.can?(:read, assignment)).to be false
    end

    it 'can read the assignment if member' do
      ability = Ability.new(user = create(:user))
      assignment = create(:assignment)
      create(:membership, user: user, course: assignment.course)

      expect(ability.can?(:read, assignment)).to be true
    end

    it 'can edit the assignment if instructor' do
      ability = Ability.new(user = create(:user))
      assignment = create(:assignment)
      create(:membership, user: user, course: assignment.course, role: :instructor)

      expect(ability.can?(:edit, assignment)).to be true
    end
  end
end

