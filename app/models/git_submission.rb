# frozen_string_literal: true

class GitSubmission < Submission
  validates :github_repository_name, presence: true

  after_commit :update_github_commit_status

  # A git submission can have automatically detected contributors
  def detectable_contributors?
    true
  end

  def git_repository_url
    "https://github.com/#{github_repository_name}.git"
  end

  def download
    `git clone #{git_repository_url} #{tempdir}`
    return unless git_commit_sha
    raise unless system("git --git-dir=#{tempdir}/.git "\
                       "checkout -f #{git_commit_sha}")
  end

  # Returns the url to a specific file on github
  def file_url(filename)
    raw_url = git_repository_url[0..-5]
    "#{raw_url}/blob/#{git_commit_sha}/#{filename}"
  end

  def commit_authors
    download
    repository.commits.map(&:author).uniq
  ensure
    cleanup
  end

  private

  def run_pre_test_checks
    detect_contributors
    detect_sha
    detect_commit_message
  end

  def detect_sha
    self.git_commit_sha ||= `git --git-dir #{tempdir}/.git log -1 --format=format:%H`
  end

  def detect_commit_message
    self.git_commit_message = `git --git-dir #{tempdir}/.git log -1 --pretty=%B`
  end

  def detect_contributors
    emails = repository.commits.map(&:author).map(&:email).uniq
    names = repository.commits.map(&:author).map(&:name).uniq
    new_contributors = contributors
    new_contributors += assignment.course.memberships
                                  .joins(user: :identities)
                                  .where('LOWER(identities.email) IN (?)', emails)
    new_contributors += assignment.course.memberships
                                  .joins(user: :identities)
                                  .where('LOWER(identities.name) IN (?)', names)
    self.contributors = []
    self.contributors = new_contributors.uniq
  end

  def repository
    GitStats::GitData::Repo.new(path: tempdir)
  end

  def github_commit_status
    return :pending if running? || queued?

    status
  end

  def update_github_commit_status
    return unless uploaded_by

    client = uploaded_by.github_client
    target_url = Rails.application.routes.url_helpers.assignment_submission_url(assignment, self)
    client.create_status(github_repository_name, git_commit_sha, github_commit_status,
                         target_url: target_url, context: 'AlphaGrader')
  rescue StandardError => e
    Rails.logger.error(e)
  end
end
