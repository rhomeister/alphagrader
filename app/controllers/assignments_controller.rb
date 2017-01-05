# frozen_string_literal: true
class AssignmentsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource through: :course

  def page_title
    'Assignments'
  end

  def show
    @submissions = @assignment.submissions
                              .accessible_by(current_ability)
                              .order('submissions.created_at desc')
    @tests = @assignment.tests
                        .accessible_by(current_ability)
                        .order('tests.created_at asc').decorate
    @hidden_test_count = @assignment.tests.count - @tests.count

    @assignment = @assignment.decorate
  end

  def new
  end

  def edit
  end

  def index
    redirect_to @course
  end

  def create
    if @assignment.update_attributes(assignment_params)
      redirect_to [@course, @assignment]
    else
      render 'edit'
    end
  end

  def update
    if @assignment.update_attributes(assignment_params)
      redirect_to [@course, @assignment]
    else
      render 'edit'
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:name, :due_date, :description)
  end
end
