# frozen_string_literal: true
class SubmissionsController < ApplicationController
  load_and_authorize_resource :assignment
  load_and_authorize_resource through: :assignment

  helper_method :git_repository_urls

  def page_title
    'Submissions'
  end

  def new
    render 'github_login_missing_error' if current_user.github.nil?
  end

  def show
    @submission = @submission.decorate
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

  def git_repository_urls
    current_user.github_repositories.map(&:clone_url)
  end

  private

  def submission_params
    params[:submission] ||= params[:git_submission]
    params.require(:submission).permit(:git_repository_url)
  end
end
