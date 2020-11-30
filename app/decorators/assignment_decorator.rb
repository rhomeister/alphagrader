# frozen_string_literal: true

class AssignmentDecorator < Draper::Decorator
  delegate_all

  def due_date
    return nil if object.due_date.nil?

    I18n.l object.due_date, format: :long
  end

  def description
    h.raw(RDiscount.new(object.description).to_html)
  end

  def submission_warning
    return if h.current_user.course_instructor?(course)

    membership = course.membership_for(h.current_user)
    return if membership.nil?

    team = membership.teams.find_by(assignment_id: id)

    return unless team.nil? || team.submissions.empty?

    h.icon 'exclamation-circle', library: :font_awesome
  end

  def submission_status_for(student)
    submission = last_submission_for(student)
    # check if the student made any submissions
    if submission
      submission.status
    else
      'unsubmitted'
    end
  end
end
