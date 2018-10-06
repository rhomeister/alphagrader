# frozen_string_literal: true

Raven.configure do |config|
  # unset config.dsn if not in production
  config.dsn = ENV.fetch('SENTRY_DSN') if Rails.env.production?
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = ['production']
end
