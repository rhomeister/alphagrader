# frozen_string_literal: true
# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD'],
  domain: 'alphagrader.com',
  address: ENV['SMTP_SERVER'],
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
