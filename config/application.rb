# frozen_string_literal: true

require_relative 'boot'

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AlphaGrader
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_mailer.default_url_options = { host: 'http://' + ENV.fetch('DOMAIN_NAME') }
    Rails.application.routes.default_url_options[:host] = ENV.fetch('DOMAIN_NAME')
  end
end
