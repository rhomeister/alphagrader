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

  def submission_for(student)
    if submissions.find { |s| s.uploaded_by_id == student.user_id }
      submissions
    end
  end

  def submission_status_for(student)
    submissions = submission_for(student)
    # check if the student made submissions
    if submissions
      submissions.pluck('status').last
    else
      'unsubmitted'
    end
  end
end
