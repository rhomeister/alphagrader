# app/controllers/github_webhooks_controller.rb
class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor

  # Handle push event
  def github_push(payload)
    commit_sha = payload['after']
    repository_name = payload['repository']['full_name']

    submission = Submission.find_by(github_repository_name: repository_name)
    return unless submission
    assignment = submission.assignment
    # TODO: find submitter!
    GitSubmission.create!(github_repository_name: repository_name,
                                   git_commit_sha: commit_sha,
                                   assignment: assignment)
  end

  # Handle create event
  def github_create(payload)
    # TODO: handle create webhook
  end

  def webhook_secret(payload)
    ENV.fetch('GITHUB_WEBHOOK_SECRET')
  end
end
