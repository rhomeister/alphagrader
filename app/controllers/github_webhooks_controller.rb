# frozen_string_literal: true
# app/controllers/github_webhooks_controller.rb
class GithubWebhooksController < ActionController::Base
  protect_from_forgery
  include GithubWebhook::Processor

  # Handle push event
  def github_push(payload)
    commit_sha = payload['after']
    repository_name = payload['repository']['full_name']

    team = Team.find_by(github_repository_name: repository_name)
    return unless team
    assignment = team.assignment
    identity = Identity.find_by(uid: payload['sender']['id'])
    uploaded_by = identity.try :user

    GitSubmission.create!(github_repository_name: repository_name,
                          git_commit_sha: commit_sha,
                          assignment: assignment,
                          uploaded_by: uploaded_by)
  end

  # Handle create event
  def github_create(payload)
    # TODO: handle create webhook
  end

  def webhook_secret(_payload)
    ENV.fetch('GITHUB_WEBHOOK_SECRET')
  end
end
