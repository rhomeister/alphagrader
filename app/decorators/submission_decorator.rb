# frozen_string_literal: true

class SubmissionDecorator < Draper::Decorator
  delegate_all

  def created_at
    return nil if object.created_at.nil?

    I18n.l object.created_at, format: :long
  end

  def uploaded_by
    object.uploaded_by.try :name
  end

  def contributor_names
    object.contributors.map(&:name).join(', ')
  end

  def team_members
    return unless object.team

    object.team.users.map(&:name).join(', ')
  end

  def status
    return h.content_tag(:i, '', class: 'fa fa-spinner fa-spin fa-2x') if !submission.checks_completed?

    label_class =
      case object.status
      when 'success'
        'success'
      when 'failure'
        'danger'
      else
        'info'
      end

    h.content_tag :span, status_text, class: "label label-#{label_class}"
  end

  private

  def status_text
    if object.status == 'failure'
      "FAILURE (#{successful_test_results_count}/#{test_results.size})"
    else
      object.status.upcase
    end
  end
end
