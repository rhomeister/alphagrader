# frozen_string_literal: true
require 'rails_helper'

feature 'Teams', type: :feature do
  include Warden::Test::Helpers

  let(:user) { create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
    OmniAuth.config.test_mode = true

    OmniAuth.config.add_mock(:github, uid: '12345',
                                      info: {
                                        name: user.name,
                                        email: user.email
                                      })
  end

  after do
    Warden.test_reset!
    Rails.application.env_config['omniauth.auth'] = nil
    ActionMailer::Base.deliveries.clear
  end

  it 'lets you create a new team as student' do
    repos = [OpenStruct.new(name: 'bar', full_name: 'foo/bar', permissions: { admin: true })]
    client = instance_double(Octokit::Client)
    allow(Octokit::Client).to receive(:new).and_return(client)
    allow(client).to receive(:repositories).and_return(repos)
    allow(client).to receive(:create_hook)

    course = create(:course, student: user)
    other_user = create(:user)
    course.memberships.create!(user: other_user, role: :student)
    assignment = create(:assignment, course: course)

    login_as(user)
    visit assignment_submissions_path(assignment)

    click_link 'Create Team'

    click_link 'Github account'

    visit assignment_submissions_path(assignment)
    click_link 'Create Team'

    within '#new_team' do
      check other_user.name
      select 'foo/bar', from: Team.human_attribute_name(:github_repository_name)
    end
    click_button 'Save'

    expect(page.body).to include other_user.name
    expect(page.body).to include 'foo/bar'
  end

  it 'lets you see teams as instructor' do
    course = create(:course, instructor: user)
    assignment = create(:assignment, course: course)
    login_as(user)

    visit course_assignment_path(course, assignment)
    click_link 'Teams'

    expect(page.body).to include I18n.t(:no_results_found)
    expect(page.body).to_not include 'The following members are not (yet) part of a team'

    membership = create(:membership, role: :student, course: course)
    visit assignment_teams_path(assignment)
    expect(page.body).to include 'The following members are not (yet) part of a team'
    expect(page.body).to include membership.name

    create(:team, memberships: [membership], assignment: assignment)
    visit assignment_teams_path(assignment)
    expect(page.body).to_not include 'The following members are not (yet) part of a team'
    expect(page.body).to include membership.name
  end
end
