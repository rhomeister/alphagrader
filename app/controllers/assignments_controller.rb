# frozen_string_literal: true

class AssignmentsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource through: :course

  def page_title
    'Assignments'
  end

  def show
    @assignment = @assignment.decorate
  end

  def new; end

  def edit; end

  def index
    redirect_to @course
  end

  def destroy
    @assignment.destroy
    redirect_to course_path(@course), flash: { success: 'Assignment was successfully deleted' }
  end

  def create
    if @assignment.update(assignment_params)
      redirect_to [@course, @assignment]
    else
      render 'edit'
    end
  end

  def update
    if @assignment.update(assignment_params)
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
