# frozen_string_literal: true
class TeamDecorator < Draper::Decorator
  delegate_all

  def created_at
    return nil if object.created_at.nil?
    I18n.l object.created_at, format: :long
  end

  def user_names
    result = users.map(&:name)
    h.safe_join(result, ', ')
  end

  def repository_owner_name
    repository_owner.try :name
  end

  def git_repository_url
    return h.content_tag(:i, 'Not set up') if github_repository_name.blank?
    git_repository_url = "https://github.com/#{github_repository_name}.git"
    h.link_to git_repository_url, git_repository_url, target: :blank
  end
end
