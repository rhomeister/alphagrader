# frozen_string_literal: true
require 'rails_helper'

describe Course, type: :model do
  it 'has an enrollment code' do
    course = create(:course)
    enrollment_code = course.enrollment_code
    expect(enrollment_code).to_not be_nil

    course.save
    expect(course.enrollment_code).to eq enrollment_code
  end

  it 'can be copied' do
    course = create(:course)
    instructor1 = create(:user)
    instructor2 = create(:user)
    student1 = create(:user)

    course.memberships.create!(user: instructor1, role: :instructor)
    course.memberships.create!(user: instructor2, role: :instructor)
    course.memberships.create!(user: student1, role: :student)

    course.assignments << assignment1 = create(:assignment)
    course.assignments << assignment2 = create(:assignment)

    # Add tests to assignments
    assignment1.tests << test11 = create(:test)
    assignment1.tests << test12 = create(:test)
    assignment2.tests << test21 = create(:test)

    # Add test results to tests
    test11.test_results << create(:test_result)
    test11.test_results << create(:test_result)
    test12.test_results << create(:test_result)
    test21.test_results << create(:test_result)

    # Add submissions to assingments
    assignment1.submissions << create(:submission)
    assignment1.submissions << create(:submission)
    assignment2.submissions << create(:submission)

    new_course = course.copy

    expect(new_course).to be_persisted
    expect(new_course.name).to eq "Copy of #{course.name}"

    # check that the instructors were copied
    expect(new_course.instructors).to match_array [instructor1, instructor2]
    # check that the students weren't copied over
    expect(new_course.users).to match_array [instructor1, instructor2]

    expect(new_course.assignments).to have(2).items
    new_assignment1 = new_course.assignments.find { |e| e.name == assignment1.name }
    expect(new_assignment1.tests).to have(2).items
    expect(new_assignment1.tests.map(&:name).sort).to eq [test11.name, test12.name].sort

    new_assignment2 = new_course.assignments.find { |e| e.name == assignment2.name }
    expect(new_assignment2.tests).to have(1).items
    expect(new_assignment2.tests.first.name).to eq test21.name

    # Test that the assingment tests don't have test results
    expect(new_assignment1.test11.test_results).to have(0).items
    expect(new_assignment1.test12.test_results).to have(0).items
    expect(new_assignment2.test21.test_results).to have(0).items

    # Test that the assignments don't have submissions
    expect(new_assignment1.submissions).to have(0).items
    expect(new_assignment2.submissions).to have(0).items

  end
end
