# frozen_string_literal: true
class Ability
  include CanCan::Ability
  attr_accessor :user

  def initialize(user)
    @user = user
    can :manage, :all if user && user.admin?

    can :read, Course, membership_params
    can :create, Course

    can [:edit, :update], Course, instructor_membership_params

    can :read, Assignment, course: { memberships: { user_id: user.id } }
    can [:create, :edit, :update], Assignment, course: instructor_membership_params

    can :read, Test, public: true, assignment: { course: membership_params }
    can :read, Test, public: false, assignment: { course: instructor_membership_params }
    can [:create, :edit, :update], Test, assignment: { course: instructor_membership_params }

    can :read, Submission, authors: { id: user.id }
    can :read, Submission, assignment: { course: instructor_membership_params }
    can [:new, :create], Submission, assignment: { course: membership_params }

    can :create, Membership, course_id: nil
  end

  private

  def instructor_membership_params
    {memberships: { user_id: user.id, role: ['instructor', Membership.roles[:instructor]] }}
  end

  def membership_params
    {memberships: { user_id: user.id }}
  end
end
