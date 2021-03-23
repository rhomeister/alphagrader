# frozen_string_literal: true

require 'rails_helper'

feature 'Assignment', type: :feature do
  include Warden::Test::Helpers
  it 'lets you create a new assignment as instructor' do
    login_as(user = create(:user))
    course = create(:course, instructor: user)

    visit course_path(course)

    click_link 'New Assignment'

    assignment_attributes = attributes_for(:assignment)

    within '#new_assignment' do
      fill_in 'assignment_name', with: assignment_attributes[:name]
      fill_in 'assignment_description', with: assignment_attributes[:description]
    end
    click_button 'Save'

    expect(page.body).to include assignment_attributes[:name]
    expect(page.body).to include assignment_attributes[:description]

    # go back to the course page
    click_link course.name
    expect(page.body).to include assignment_attributes[:name]

    # go back to the assignment page
    click_link(assignment_attributes[:name], match: :first)
    expect(page.body).to include assignment_attributes[:name]
  end

  it 'does not let you create a new assignment as student' do
    login_as(user = create(:user))
    course = create(:course, student: user)

    visit course_path(course)
    expect(page.body).to_not include 'New Assignment'
  end

  it 'lets you view an assignment as student' do
    login_as(user = create(:user))
    course = create(:course, student: user)
    course.assignments << assignment = create(:assignment)

    visit course_path(course)
    expect(page.body).to include assignment.name

    click_link(assignment.name, match: :first)
    # go back to the assignment page
    expect(page.body).to include assignment.name
    expect(page.body).to include assignment.description
  end
end
