# frozen_string_literal: true
class Ability
  include CanCan::Ability
  attr_accessor :user

  def initialize(user)
    return if user.nil?
    @user = user
    can :manage, :all if user && user.admin?

    setup_course_rights
    setup_assignment_rights
    setup_test_rights
    setup_submission_rights
    setup_team_rights

    can :create, Membership, course_id: nil
  end

  private

  def setup_course_rights
    can :read, Course, membership_params
    can :create, Course if user.instructor? || user.admin?

    can [:edit, :update, :duplicate], Course, instructor_membership_params
  end

  def setup_assignment_rights
    can :read, Assignment, course: { memberships: { user_id: user.id } }
    can [:create, :edit, :update], Assignment, course: instructor_membership_params
  end

  def setup_test_rights
    can :read, Test, public: true, assignment: { course: membership_params }
    can :read, Test, public: false, assignment: { course: instructor_membership_params }
    can [:create, :edit, :update, :destroy], Test, assignment: { course: instructor_membership_params }
  end

  def setup_submission_rights
    can :read, Submission, team: membership_params
    can :read, Submission, assignment: { course_id: instructor_course_ids }
    can [:new, :create], Submission, assignment: { course: membership_params }
  end

  def setup_team_rights
    can [:read], Team, memberships: { user_id: user.id }
    can [:edit, :update], Team, repository_owner_id: user.id
    can [:read, :edit, :update], Team, assignment: { course_id: instructor_course_ids }
    can [:new, :create], Team, assignment: { course: membership_params }
  end

  def instructor_course_ids
    @instructor_course_ids ||= user.memberships.instructor.pluck(:course_id)
  end

  def instructor_membership_params
    { memberships: { user_id: user.id, role: Membership.roles[:instructor] } }
  end

  def membership_params
    { memberships: { user_id: user.id } }
  end
end
