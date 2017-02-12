# frozen_string_literal: true
class TeamsController < ApplicationController
  load_and_authorize_resource :assignment
  load_and_authorize_resource through: :assignment

  helper_method :github_repository_names, :membership_candidates

  def page_title
    'Teams'
  end

  def new
    render 'github_account_missing_error' if current_user.github.nil?
  end

  def index
  end

  def edit
  end

  def update
    if @team.update_attributes(team_params)
      @team.memberships << @assignment.course.membership_for(current_user)
      @team.remove_duplicate_members
      redirect_to assignment_submissions_path(@assignment)
    else
      render 'edit'
    end
  end

  def create
    @team.memberships << @assignment.course.membership_for(current_user)
    @team.repository_owner = current_user
    if @team.save
      redirect_to assignment_submissions_path(@assignment)
    else
      render 'new'
    end
  end

  def github_repository_names
    current_user.github_repositories_with_admin_permissions.map(&:full_name)
  end

  def membership_candidates
    @assignment.course.memberships.student.includes(:user)
  end

  private

  def team_params
    params.require(:team).permit(:github_repository_name, membership_ids: [])
  end
end
