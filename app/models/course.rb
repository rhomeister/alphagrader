# frozen_string_literal: true
class Course < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :instructor_memberships, -> { instructor },
           class_name: 'Membership', source: :course
  has_many :instructors, through: :instructor_memberships, class_name: 'User', source: :user

  has_many :assignments, dependent: :destroy

  validates :name, presence: true

  before_save do
    next unless enrollment_code.nil?
    assign_enrollment_code
  end

  # creates a copy of the course with the same instructors for a new semester
  def copy
    result = dup
    result.name = "Copy of #{name}"
    result.assign_enrollment_code
    result.save!
    instructors.each do |instructor|
      result.memberships.create!(user: instructor, role: :instructor)
    end
    result.assignments = assignments.map(&:copy)
    result
  end

  def assign_enrollment_code
    loop do
      self.enrollment_code = SecureRandom.hex[0..5].upcase
      existing = Course.find_by(enrollment_code: enrollment_code)
      break if existing.nil?
    end
  end

  def membership_for(current_user)
    memberships.find { |m| m.user_id == current_user.id }
  end
end
