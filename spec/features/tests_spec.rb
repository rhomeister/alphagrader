# frozen_string_literal: true
require 'rails_helper'

feature 'Tests', type: :feature do
  include Warden::Test::Helpers
  it 'lets you create a new test as instructor' do
    login_as(user = create(:user))
    course = create(:course, instructor: user)
    assignment = create(:assignment, course: course)

    visit assignment_tests_path(assignment)

    click_link 'New Test'

    click_link 'expected_output_test'

    test_attributes = attributes_for(:expected_output_test)

    within '#new_expected_output_test' do
      fill_in 'expected_output_test_name', with: test_attributes[:name]
      fill_in 'expected_output_test_description', with: test_attributes[:description]
      fill_in 'expected_output_test_program_input', with: test_attributes[:program_input]
      fill_in 'expected_output_test_expected_program_output', with: test_attributes[:expected_program_output]
      check 'expected_output_test_public'
    end
    click_button 'Save'

    expect(page.body).to include test_attributes[:name]
    expect(page.body).to include test_attributes[:description]
  end

  it 'lets you edit and delete a test as instructor' do
    login_as(user = create(:user))
    course = create(:course, instructor: user)
    assignment = create(:assignment, course: course)
    assignment.tests << test = create(:expected_output_test, public: true)

    visit assignment_tests_path(assignment)
    click_link "edit_test_#{test.id}"

    within '.edit_expected_output_test' do
      fill_in 'expected_output_test_name', with: 'New test name'
    end
    click_button 'Save'
    expect(page.body).to include 'New test name'

    click_link "delete_test_#{test.id}"
    expect(page.body).to include 'Test was successfully deleted'
    expect(page.body).to_not include 'New test name'
  end

  it 'does not let you create a new test as student' do
    login_as(user = create(:user))
    course = create(:course, student: user)
    assignment = create(:assignment, course: course)

    visit course_assignment_path(course, assignment)
    expect(page.body).to_not include 'New Test'
  end

  it 'lets you view a public test as student' do
    login_as(user = create(:user))
    course = create(:course, student: user)
    assignment = create(:assignment, course: course)
    assignment.tests << test = create(:expected_output_test, public: true)

    visit assignment_tests_path(assignment)
    expect(page.body).to include test.name
  end

  it 'does not let you edit or delete a test as student' do
    login_as(user = create(:user))
    course = create(:course, student: user)
    assignment = create(:assignment, course: course)
    assignment.tests << test = create(:expected_output_test, public: true)

    visit assignment_tests_path(assignment)
    expect(page.body).to_not include 'Edit'
    expect(page.body).to_not include "delete_test_#{test.id}"
  end

  it 'does not let you view a private test as student' do
    login_as(user = create(:user))
    course = create(:course, student: user)
    assignment = create(:assignment, course: course)
    assignment.tests << test = create(:expected_output_test, public: false)

    visit assignment_tests_path(assignment)
    expect(page.body).to include '1 test(s) are marked private'
    expect(page.body).to_not include test.name
  end
end
