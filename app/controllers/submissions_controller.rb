# frozen_string_literal: true
class SubmissionsController < ApplicationController
  load_and_authorize_resource :assignment
  load_and_authorize_resource through: :assignment

  helper_method :github_repository_names

  def page_title
    'Submissions'
  end

  def show
    @submission = @submission.decorate
    @test_results = @submission.test_results.decorate
  end

  private

  def submission_params
    params[:submission] ||= params[:git_submission]
    params.require(:submission).permit(:github_repository_name)
  end
end
