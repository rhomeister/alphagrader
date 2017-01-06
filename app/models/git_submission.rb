# frozen_string_literal: true
class GitSubmission < Submission
  validates :github_repository_name, presence: true

  after_create :create_github_webhook
  after_commit :update_github_commit_status

  def git_repository_url
    "https://github.com/#{github_repository_name}.git"
  end

  def download
    `git clone #{git_repository_url} #{tempdir}`
    return unless git_commit_sha
    Dir.chdir(tempdir) do
      `git checkout -f #{git_commit_sha}`
    end
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
    self.git_commit_sha ||= repository.commits.last.sha
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

  def create_github_webhook
    return unless uploaded_by
    uploaded_by.create_github_webhook(github_repository_name)
  rescue
  end

  def update_github_commit_status
    return unless uploaded_by
    client = uploaded_by.github_client
    client.create_status(github_repository_name, git_commit_sha, status) rescue nil
  end
end
