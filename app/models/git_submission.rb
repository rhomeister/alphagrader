# frozen_string_literal: true
class GitSubmission < Submission
  validates :github_repository_name, presence: true

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
    detect_contributors
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
      test_result = test.run(self)
      test_result.submission = self
      test_result.save!
    end
  end

  def detect_sha
    self.git_commit_sha ||= `git --git-dir #{tempdir}/.git log -1 --format=format:%H`
  end

  def detect_commit_message
    self.git_commit_message = `git --git-dir #{tempdir}/.git log -1 --pretty=%B`
  end

  def detect_contributors
    emails = repository.commits.map(&:author).map(&:email).uniq
    new_contributors = contributors + assignment.course.memberships
                       .joins(user: :identities)
                       .where(identities: { email: emails })
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
