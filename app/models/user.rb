# frozen_string_literal: true
class User < ApplicationRecord
  attr_accessor :oauth_callback
  attr_accessor :current_password
  attr_accessor :instructor

  validates :name, presence: { if: :email_required? }

  validates :email, presence: { if: :email_required? }
  validates :email, uniqueness: { allow_blank: true, if: :email_changed? }
  validates :email, format: { with: Devise.email_regexp, allow_blank: true, if: :email_changed? }

  validates :password, presence: { if: :password_required? }
  validates :password, confirmation: { if: :password_required? }
  validates :password, length: { within: Devise.password_length, allow_blank: true }

  has_many :memberships, dependent: :destroy
  has_many :courses, through: :memberships
  has_many :teams, through: :memberships
  has_many :uploads, class_name: 'Submission',
                     foreign_key: :uploaded_by_id, dependent: :destroy

  has_and_belongs_to_many :submissions, join_table: :author_submissions,
                                        foreign_key: :author_id,
                                        inverse_of: :authors

  before_save do
    self.role = :instructor if instructor == '1' || instructor == true
  end

  def password_required?
    return false if email.blank? || !email_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    @oauth_callback != true
  end

  has_many :identities, dependent: :destroy
  enum role: [:user, :admin, :instructor]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  def github
    @github ||= identities.find_by(provider: 'github')
  end

  def github_client
    @github_client ||= Octokit::Client.new(access_token: github.accesstoken)
  end

  def github_repositories
    @github_repositories ||= github_client.repositories
  end

  def github_repositories_with_admin_permissions
    github_repositories.select { |e| e[:permissions][:admin] }
  end

  def create_github_webhook(repository)
    url = Rails.application.routes.url_helpers.github_webhooks_url
    github_client.create_hook(repository, 'web',
                              { url: url, content_type: :json,
                                secret: ENV.fetch('GITHUB_WEBHOOK_SECRET') },
                              events: ['push'], active: true)
  end

  def facebook
    identities.find_by(provider: 'facebook')
  end

  def facebook_client
    @facebook_client ||= Facebook.client(access_token: facebook.accesstoken)
  end

  def google_oauth2
    identities.find_by(provider: 'google_oauth2')
  end

  def google_oauth2_client
    @google_oauth2_client ||= GoogleAppsClient.client(google_oauth2)
  end

  def twitter
    identities.find_by(provider: 'twitter')
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_APP_ID']
      config.consumer_secret     = ENV['TWITTER_APP_SECRET']
      config.access_token        = twitter.accesstoken
      config.access_token_secret = twitter.secrettoken
    end
  end

  def course_instructor?(course)
    course.instructors.include? self
  end
end
