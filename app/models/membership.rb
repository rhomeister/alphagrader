# frozen_string_literal: true
class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum role: [:user, :instructor]

  attr_accessor :enrollment_code

  validates :user, presence: true
  validates :course, presence: true

  validates :course, uniqueness: { scope: :user_id }

  before_validation do
    next if enrollment_code.blank?
    self.course = Course.find_by(enrollment_code: enrollment_code)
  end
end
