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
    label_class =
      case object.status
      when 'success'
        'success'
      when 'failure'
        'danger'
      else
        'info'
      end

    h.content_tag :span, object.status.upcase, class: "label label-#{label_class}"
  end
end
