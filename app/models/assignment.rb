# frozen_string_literal: true
class Assignment < ApplicationRecord
  belongs_to :course, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :tests, dependent: :destroy

  validates :name, presence: true
end
