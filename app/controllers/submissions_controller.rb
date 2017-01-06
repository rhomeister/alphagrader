# frozen_string_literal: true
class SubmissionsController < ApplicationController
  load_and_authorize_resource :assignment
  load_and_authorize_resource through: :assignment

  helper_method :github_repository_names

  def page_title
    'Submissions'
  end

  def new
    render 'github_account_missing_error' if current_user.github.nil?
  end

  def show
    @submission = @submission.decorate
    @test_results = @submission.test_results.decorate
  end

  def create
    @submission = @submission.becomes(GitSubmission)
    @submission.type = GitSubmission
    @submission.uploaded_by = current_user
    if @submission.save
      redirect_to assignment_submission_path(@assignment, @submission)
    else
      render 'new'
    end
  end

  def github_repository_names
    current_user.github_repositories.map(&:full_name)
  end

  private

  def submission_params
    params[:submission] ||= params[:git_submission]
    params.require(:submission).permit(:github_repository_name)
  end
end
