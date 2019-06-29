# frozen_string_literal: true

class Assignment < ApplicationRecord
  belongs_to :course, inverse_of: :assignments
  has_many :submissions, dependent: :destroy, inverse_of: :assignment
  has_many :tests, dependent: :destroy, inverse_of: :assignment
  has_many :teams, dependent: :destroy, inverse_of: :assignment

  validates :name, presence: true

  def members_without_team
    course.memberships.student - teams.flat_map(&:memberships)
  end

  def copy
    result = dup
    result.tests = tests.map(&:dup)
    result
  end
end
