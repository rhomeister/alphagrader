# frozen_string_literal: true
class CoursesController < ApplicationController
  load_and_authorize_resource

  def page_title
    'Courses'
  end

  def index
    @courses = @courses.includes(:instructors).order(:id)
    @instructor_courses = @courses.select { |c| current_user.course_instructor?(c) }
    @courses = @courses.decorate
  end

  def show
    @assignments = @course.assignments
    @course = @course.decorate
  end

  def edit
  end

  def create
    if @course.update_attributes(course_params)
      @course.memberships.create!(user: current_user, role: :instructor)
      redirect_to @course
    else
      render 'new'
    end
  end

  def update
    if @course.update_attributes(course_params)
      redirect_to @course
    else
      render 'edit'
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description)
  end
end
