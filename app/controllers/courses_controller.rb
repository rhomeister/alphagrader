# frozen_string_literal: true
class CoursesController < ApplicationController
  load_and_authorize_resource

  def page_title
    'Courses'
  end

  def index
    @courses = @courses.includes(:instructors).decorate
  end

  def show
    @assignments = @course.assignments
  end
end
