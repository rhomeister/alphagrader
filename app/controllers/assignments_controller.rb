# frozen_string_literal: true
class AssignmentsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource through: :course

  def page_title
    'Assignments'
  end

  def show
    @submissions = @assignment.submissions.accessible_by(current_ability)
  end
end
