# frozen_string_literal: true
class Course < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  has_many :instructor_memberships, -> { instructor },
           class_name: 'Membership', source: :course
  has_many :instructors, through: :instructor_memberships, class_name: 'User', source: :user

  has_many :assignments

  before_save do
    loop do
      self.enrollment_code = SecureRandom.hex[0..5].upcase
      existing = Course.find_by(enrollment_code: enrollment_code)
      break if existing.nil?
    end
  end
end
