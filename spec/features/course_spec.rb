# frozen_string_literal: true
require 'rails_helper'

feature 'Courses', type: :feature do
  it 'lets you create a new course' do
    login_as(create(:user, role: :instructor))

    visit root_path

    expect(page.body).to include(I18n.t('courses.list'))

    click_link I18n.t('courses.new')
    course_attributes = attributes_for(:course)

    within '#new_course' do
      fill_in 'course_name', with: course_attributes[:name]
      fill_in 'course_description', with: course_attributes[:description]
    end

    click_button 'Save'

    expect(page.body).to include(course_attributes[:name])
    expect(page.body).to include('To invite students, give them the following code:')
    expect(page.body).to include(course_attributes[:description])
  end

  it 'lets you enroll in a course' do
    course = create(:course)
    create(:membership, role: :instructor, course: course)
    login_as(create(:user))

    visit root_path

    click_link I18n.t('enrollments.new')
    within '#new_membership' do
      fill_in 'membership_enrollment_code', with: course.enrollment_code
    end
    click_button 'Search'

    expect(page.body).to include course.name
    expect(page.body).to include course.instructors.first.name

    click_button 'Enroll'

    expect(page.body).to include(course.name)
    expect(page.body).to include('You have enrolled successfully')
    expect(page.body).to_not include('To invite students, give them the following code:')
  end

  it 'lists courses' do
    course = create(:course)
    user = create(:user)
    create(:membership, role: :instructor, course: course, user: user)
    login_as(user)

    visit root_path
    expect(page.body).to include(course.name)
  end
end
