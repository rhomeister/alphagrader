# frozen_string_literal: true

redis_config = {
  url: "redis://#{ENV['REDIS_HOST'] || 'localhost'}:6379",
  password: ENV['REDIS_PASSWORD'],
  namespace: 'alphagrader'
}

Sidekiq.options[:poll_interval] = 2

Sidekiq.configure_server do |config|
  sidekiq_config = YAML.safe_load(File.new("#{Rails.root}/config/sidekiq.yml"), [Symbol])
  config.redis = redis_config
  schedule_file = 'config/sidekiq_schedule.yml'

  # set the ActiveRecord pool size equal to concurrency

  if defined?(ActiveRecord::Base)
    config = ActiveRecord::Base.configurations[Rails.env] ||
             Rails.application.config.database_configuration[Rails.env]

    # not sure why +1 is necessary, but otherwise getting
    # ActiveRecord::ConnectionTimeOut errors
    config = config.dup
    config['pool'] = sidekiq_config[:concurrency] + 1
    ActiveRecord::Base.establish_connection(config)
  end

  Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
