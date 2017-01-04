class SubmissionDecorator < Draper::Decorator
  delegate_all

  def created_at
    return nil if object.created_at.nil?
    I18n.l object.created_at, format: :long
  end

  def uploaded_by
    object.uploaded_by.name
  end

  def git_repository_url
    h.link_to object.git_repository_url, object.git_repository_url, target: :blank
  end
end
