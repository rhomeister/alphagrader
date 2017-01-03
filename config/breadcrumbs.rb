# frozen_string_literal: true
crumb :root do
  link 'Home', root_path
end

crumb :course do |course|
  link course.name, course_path(course)
end

crumb :assignment do |assignment|
  link assignment.name, course_assignment_path(assignment.course, assignment)
  parent :course, assignment.course
end
