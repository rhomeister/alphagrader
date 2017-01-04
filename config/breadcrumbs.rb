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

crumb :submission do |submission|
  if submission.persisted?
    url = assignment_submission_path(submission.assignment, submission)
  else
    url = nil
  end
  text = submission.decorate.created_at || 'New Submission'
  link text, url
  parent :assignment, submission.assignment
end
