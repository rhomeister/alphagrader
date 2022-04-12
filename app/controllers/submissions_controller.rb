# frozen_string_literal: true

class SubmissionsController < ApplicationController
  before_action :normalize_params

  load_and_authorize_resource :assignment
  before_action :build_resource, only: [:create]
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

    respond_to do |format|
      format.html
      format.csv { send_data @submissions.to_csv, filename: 'data.csv' }
    end
  end

  def show
    @submission = @submission.decorate
    @test_results = @submission.test_results.order(:test_id).decorate
  end

  def new
    @submission = @submission.becomes(FileSubmission)
  end

  def create
    @submission.team = current_user.teams.find_by(assignment_id: @assignment.id)
    @submission.uploaded_by = current_user
    if @submission.update(submission_params)
      redirect_to assignment_submission_path(@assignment, @submission),
                  flash: { success: 'Submission was successfully created' }
    else
      render 'new'
    end
  end

  def rerun_all
    @submissions.each(&:rerun_tests)
    flash[:success] = 'All submissions have been enqueued for rechecking'
    redirect_to action: 'index'
  end

  def export
    respond_to do |format|
      format.html
      format.csv { send_data @submissions.to_csv, filename: 'data.csv' }
    end
  end

  private

  def normalize_params
    params[:submission] ||= [:file_submission].map do |key|
      params[key]
    end.compact.first
  end

  def submission_params
    params[:submission] ||= params[:git_submission] || params[:file_submission]
    params.require(:submission).permit(:github_repository_name, :file, :language)
  end

  def type_param
    params[:type] || params.dig(:submission, :type).try(:underscore)
  end

  def build_resource
    @submission = FileSubmission.new(submission_params)
    @submission.assignment = @assignment
    @submission
  end
end
