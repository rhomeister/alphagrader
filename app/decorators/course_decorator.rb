# frozen_string_literal: true

class CourseDecorator < Draper::Decorator
  delegate_all

  def instructor_names
    object.instructors.map(&:name).join(', ')
  end

  def description
    h.raw(RDiscount.new(object.description).to_html)
  end
end
