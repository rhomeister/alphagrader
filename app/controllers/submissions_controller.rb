# frozen_string_literal: true
class SubmissionsController < ApplicationController
  load_and_authorize_resource :assignment
  load_and_authorize_resource through: :assignment

  helper_method :github_repository_names

  def page_title
    'Submissions'
  end

  def index
    @submissions = @submissions.order('submissions.created_at desc')
    @active_team = @assignment.teams.joins(:memberships)
                              .accessible_by(current_ability)
                              .find_by(memberships: { user_id: current_user.id })
    @active_team = @active_team.try(:decorate)
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
