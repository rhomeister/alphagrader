class CourseDecorator < Draper::Decorator
  delegate_all

  def instructors
    object.instructors.map(&:name).join(', ')
  end
end
