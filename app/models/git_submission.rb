# frozen_string_literal: true
class GitSubmission < Submission
  validates :git_repository_url, presence: true

  def download
    `git clone #{git_repository_url} #{tempdir}`
  end

  def run_tests
    download
    detect_authors
    detect_sha
    save!
  rescue
    cleanup
  end

  private

  def detect_sha
    self.git_commit_sha = repository.commits.last.sha
  end

  def detect_authors
    emails = repository.commits.map(&:author).map(&:email).uniq
    new_authors = authors + User.joins(:identities).where(identities: { email: emails })
    self.authors = []
    self.authors = new_authors.uniq
  end

  def repository
    GitStats::GitData::Repo.new(path: tempdir)
  end
end
