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

  def git_commit_sha
    raw_url = object.git_repository_url[0..-5]
    h.link_to object.git_commit_sha, "#{raw_url}/commit/#{object.git_commit_sha}", target: :blank
  end

  def authors
    object.authors.map(&:name).join(', ')
  end
end
