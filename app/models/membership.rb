# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_and_belongs_to_many :teams

  enum role: %i[student instructor]

  scope :student, -> { where(role: [nil, :student]) }

  attr_accessor :enrollment_code

  validates :user, presence: true
  validates :course, presence: true

  validates :course, uniqueness: { scope: :user_id }

  has_many :contributions, inverse_of: :user
  has_many :submissions, through: :contributions

  delegate :name, :email, to: :user

  before_validation do
    next if enrollment_code.blank?

    self.course = Course.find_by(enrollment_code: enrollment_code)
  end

  def instructor
    instructor?
  end

  def instructor=(value)
    value = ActiveRecord::Type::Boolean.new.cast(value)
    self.role = value ? :instructor : nil
  end
end
