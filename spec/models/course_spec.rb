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
end
