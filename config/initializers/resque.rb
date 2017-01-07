# frozen_string_literal: true
REDIS_URL = ENV['REDISTOGO_URL'] || 'localhost:6379'
Resque.redis = REDIS_URL
