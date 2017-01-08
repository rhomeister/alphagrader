# frozen_string_literal: true
crumb :root do
  link 'Home', root_path
end

crumb :new_enrollment do
  link t('enrollments.new'), nil
end

crumb :course do |course|
  url = course_path(course) if course.persisted?
  text = course.name || 'New Course'
  link text, url
end

crumb :assignment do |assignment|
  url = if assignment.persisted?
          course_assignment_path(assignment.course, assignment)
        end
  text = assignment.name || 'New Assignment'
  link text, url
  parent :course, assignment.course
end

crumb :submission do |submission|
  url = if submission.persisted?
          assignment_submission_path(submission.assignment, submission)
        end
  text = submission.decorate.created_at || 'New Submission'
  link text, url
  parent :assignment, submission.assignment
end

crumb :team do |team|
  url = (assignment_team_path(team.assignment, team) if team.persisted?)
  text = team.decorate.created_at || 'New Team'
  link text, url
  parent :assignment, team.assignment
end

crumb :test do |test|
  url = (assignment_submission_path(test.assignment, test) if test.persisted?)
  text = test.name || 'New Test'
  link text, url
  parent :assignment, test.assignment
end
