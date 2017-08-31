# frozen_string_literal: true
require 'rails_helper'

feature 'Submissions', type: :feature do
  include Warden::Test::Helpers

  let(:user) { create(:user) }

  it 'lets you see your submissions as student' do
    course = create(:course, student: user)
    assignment = create(:assignment, course: course)

    user = create(:user)
    membership = course.memberships.create!(user: user, role: :student)
    team = create(:team, memberships: [membership], assignment: assignment)

    other_membership = course.memberships.create!(role: :student, user: create(:user))
    other_team = create(:team, memberships: [other_membership], assignment: assignment)
    other_team.submissions << submission = create(:file_submission, assignment: assignment)

    login_as(user)
    visit assignment_submissions_path(assignment)
    # you shouldn't be able to see other people's submissions
    expect(page.body).to include I18n.t(:no_results_found)

    team.submissions << create(:file_submission, assignment: assignment)
    visit assignment_submissions_path(assignment)
    expect(page.body).to_not include I18n.t(:no_results_found)
    expect(page.body).to include submission.decorate.created_at

    click_link submission.decorate.created_at
  end

  it 'lets you see all submissions as instructor' do
    course = create(:course, instructor: user)
    assignment = create(:assignment, course: course)
    login_as(user)

    membership1 = course.memberships.create!(role: :student, user: create(:user))
    team1 = create(:team, memberships: [membership1], assignment: assignment)
    team1.submissions << submission1 = create(:file_submission, assignment: assignment)

    membership2 = course.memberships.create!(role: :student, user: create(:user))
    team2 = create(:team, memberships: [membership2], assignment: assignment)
    team2.submissions << submission2 = create(:file_submission, assignment: assignment)

    login_as(user)
    visit assignment_submissions_path(assignment)

    expect(page.body).to include submission1.decorate.created_at
    expect(page.body).to include submission2.decorate.created_at
  end
end
