# frozen_string_literal: true
class EnrollmentsController < ApplicationController
  load_and_authorize_resource class: 'Membership'

  def page_title
    'Enrollment'
  end

  def new
    @enrollment_code = params.dig(:membership, :enrollment_code)
    return unless @enrollment_code
    @enrollment_code.upcase!
    @course = Course.find_by(enrollment_code: @enrollment_code)
    @course = @course.try(:decorate)
  end

  def create
    @enrollment.user = current_user
    if @enrollment.save
      redirect_to @enrollment.course, flash: { success: 'You have enrolled successfully' }
    else
      redirect_to action: :new
    end
  end

  private

  def enrollment_params
    params.require(:membership).permit(:enrollment_code)
  end
end
