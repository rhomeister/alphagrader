# frozen_string_literal: true
class Assignment < ApplicationRecord
  belongs_to :course, dependent: :destroy, inverse_of: :assignments
  has_many :submissions, dependent: :destroy, inverse_of: :assignment
  has_many :tests, dependent: :destroy, inverse_of: :assignment
  has_many :teams, dependent: :destroy, inverse_of: :assignment

  validates :name, presence: true

  amoeba do
    exclude_association [:submissions, :teams]
  end

  def members_without_team
    course.memberships.student - teams.flat_map(&:memberships)
  end
end
