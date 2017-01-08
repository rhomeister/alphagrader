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

  def git_repository_url
    h.link_to object.git_repository_url, object.git_repository_url, target: :blank
  end

  def git_commit_sha
    return nil if object.git_commit_sha.blank?
    raw_url = object.git_repository_url[0..-5]
    h.content_tag :samp do
      h.content_tag :strong do
        h.link_to object.git_commit_sha, "#{raw_url}/commit/#{object.git_commit_sha}", target: :blank
      end
    end
  end

  def git_commit_message
    h.content_tag :samp do
      h.content_tag :strong, object.git_commit_message
    end
  end

  def authors
    object.authors.map(&:name).join(', ')
  end

  def team_members
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
