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

  context 'assignments' do
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

      expect(ability.can?(:edit, assignment.reload)).to be true
    end
  end

  context 'tests' do
    it 'cannot read the test without being member' do
      ability = Ability.new(create(:user))
      test = create(:test)

      expect(ability.can?(:read, test)).to be false
    end

    it 'can read a public test if member' do
      ability = Ability.new(user = create(:user))
      assignment = create(:assignment)
      test = create(:test, assignment: assignment, public: true)
      create(:membership, user: user, course: assignment.course)

      expect(ability.can?(:read, test)).to be true
    end

    it 'cannot read a private test if member' do
      ability = Ability.new(user = create(:user))
      assignment = create(:assignment)
      test = create(:test, assignment: assignment, public: false)
      create(:membership, user: user, course: assignment.course)

      expect(ability.can?(:read, test)).to be false
    end

    it 'can read a private test if instructor' do
      ability = Ability.new(user = create(:user))
      assignment = create(:assignment)
      test = create(:test, assignment: assignment, public: false)
      create(:membership, user: user, course: assignment.course, role: :instructor)

      expect(ability.can?(:read, test)).to be true
    end

    it 'can edit the test if instructor' do
      ability = Ability.new(user = create(:user))
      assignment = create(:assignment)
      test = create(:test, assignment: assignment, public: false)
      create(:membership, user: user, course: assignment.course, role: :instructor)

      expect(ability.can?(:edit, test)).to be true
    end
  end
end
