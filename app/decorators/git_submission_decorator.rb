# frozen_string_literal: true
class GitSubmissionDecorator < SubmissionDecorator
  delegate_all

  def attributes
    [:status, :uploaded_by, :created_at, :git_repository_url, :git_commit_sha,
     :git_commit_message, :contributor_names, :team_members]
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
end
