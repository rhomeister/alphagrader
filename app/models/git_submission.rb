# frozen_string_literal: true
class GitSubmission < Submission
  validates :git_repository_url, presence: true

  def download
    `git clone #{git_repository_url} #{tempdir}`
  end

  def run_tests
    test_results.destroy_all
    download
    detect_authors
    detect_sha
    detect_commit_message
    self.status = :running
    save!
    run_user_tests
    detect_status
    save!
  ensure
    cleanup
  end

  private

  def detect_status
    self.status = test_results.reload.all?(&:success?) ? :success : :failure
  end

  def run_user_tests
    assignment.tests.each do |test|
      test_result = test.run(tempdir)
      test_result.submission = self
      test_result.save!
    end
  end

  def detect_sha
    self.git_commit_sha = repository.commits.last.sha
  end

  def detect_commit_message
    self.git_commit_message = `git --git-dir #{tempdir}/.git log -1 --pretty=%B`
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
