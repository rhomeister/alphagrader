class Team < ApplicationRecord
  belongs_to :assignment, inverse_of: :teams

  has_and_belongs_to_many :memberships
  has_many :users, through: :memberships
  belongs_to :repository_owner, class_name: 'User'

  after_save :create_github_webhook

  validates :github_repository_name, uniqueness: true, presence: true

  private

  def create_github_webhook
    repository_owner.create_github_webhook(github_repository_name)
  rescue StandardError => e
    Rails.logger.error(e)
  end
end
