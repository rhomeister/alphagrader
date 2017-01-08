# frozen_string_literal: true
class Ability
  include CanCan::Ability
  attr_accessor :user

  def initialize(user)
    @user = user
    can :manage, :all if user && user.admin?

    can :read, Course, membership_params
    can :create, Course if user.instructor? || user.admin?

    can [:edit, :update], Course, instructor_membership_params

    can :read, Assignment, course: { memberships: { user_id: user.id } }
    can [:create, :edit, :update], Assignment, course: instructor_membership_params

    can :read, Test, public: true, assignment: { course: membership_params }
    can :read, Test, public: false, assignment: { course: instructor_membership_params }
    can [:create, :edit, :update, :destroy], Test, assignment: { course: instructor_membership_params }

    can :read, Submission, authors: { id: user.id }
    can :read, Submission, assignment: { course: instructor_membership_params }

    can [:read], Team, memberships: { user_id: user.id }
    can [:edit, :update], Team, repository_owner_id: user.id
    can [:read, :edit, :update], Team, assignment: { course_id: instructor_course_ids }
    can [:new, :create], Team, assignment: { course: membership_params }

    can :create, Membership, course_id: nil
  end

  private

  def instructor_course_ids
    @instructor_course_ids ||= user.memberships.instructor.pluck(:course_id)
  end

  def instructor_membership_params
    { memberships: { user_id: user.id, role: ['instructor', Membership.roles[:instructor]] } }
  end

  def membership_params
    { memberships: { user_id: user.id } }
  end
end
