# frozen_string_literal: true
class Team < ApplicationRecord
  belongs_to :assignment, inverse_of: :teams

  has_and_belongs_to_many :memberships
  has_many :users, through: :memberships
  has_many :submissions, inverse_of: :team
  belongs_to :repository_owner, class_name: 'User'

  before_validation :remove_duplicate_members
  after_save :create_github_webhook

  validates :github_repository_name, uniqueness: true, presence: true

  def remove_duplicate_members
    all_memberships = memberships.to_a.uniq(&:id)
    memberships.clear
    self.memberships = all_memberships
  end

  private

  def create_github_webhook
    repository_owner.create_github_webhook(github_repository_name)
  rescue StandardError => e
    Rails.logger.error(e)
  end
end
