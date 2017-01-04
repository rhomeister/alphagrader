# frozen_string_literal: true
class GitSubmission < Submission
  validates :git_repository_url, presence: true
end
