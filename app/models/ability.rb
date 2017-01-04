# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user && user.admin?

    can :read, Course, memberships: { user_id: user.id }

    can :read, Assignment, course: { memberships: { user_id: user.id } }

    can :read, Submission, authors: { id: user.id }
    can [:new, :create], Submission, assignment: { course: { memberships: { user_id: user.id  }}}
    can :create, Membership, course_id: nil
  end
end
