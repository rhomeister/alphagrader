# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# gem 'airbrake', '~> 4.1'
gem 'sentry-raven'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Unicorn as the app server
gem 'unicorn'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
#
gem 'haml'

gem 'aws-sdk-s3', '~> 1.82.0'
gem 'paperclip'
gem 'rubyzip', '~> 2.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
gem 'redis-namespace'
# Use Redis adapter to run Action Cable in production
gem 'redis'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'simple_form', '~> 5.0.3'

gem 'dotenv-rails', require: 'dotenv/rails-now'

gem 'rich_pluralization',
    git: 'https://github.com/rhomeister/rich_pluralization.git',
    ref: '318b16d'

gem 'rdiscount'

gem 'git_stats'

# gem 'resque'
# gem 'resque-web', require: 'resque_web'

gem 'sidekiq'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker', '~> 2.14.0'
  gem 'rubocop-faker' # required to update positional arguments to keywords arguments for faker
  gem 'pry'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'

  # gem 'happy_seed'
  gem 'letter_opener'

  gem 'brakeman', '~> 4.10.0', require: false
  gem 'rubocop', '~> 0.92.0', require: false

  # capistrano

  gem 'capistrano', '~> 3.8', require: false, group: :development
  # Deploy with capistrano, see config/deploy.rb
  gem 'capistrano-bundler', '~> 1.6.0', require: false
  gem 'capistrano-postgresql', '~> 4.2.1', require: false
  gem 'capistrano-rails', '~> 1.1', require: false
  gem 'capistrano-safe-deploy-to', '~> 1.1.1', require: false
  gem 'rvm1-capistrano3', '~> 1.3.2', require: false
  # gem 'capistrano-memcached', '~> 1.2.0', require: false
  gem 'capistrano-unicorn-nginx', '~> 4.1', require: false
  # gem 'capistrano-faster-assets', '~> 1.0.2', require: false
  gem 'capistrano-sidekiq', '~> 1.0.3', require: false
end

group :test do
  gem 'capybara', '~> 3.33.0'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'vcr'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bh'
gem 'bootstrap-sass'
gem 'cancancan'
gem 'devise'
gem 'github_webhook', '~> 1.1.2'
gem 'meta-tags', require: 'meta_tags'
gem 'modernizr-rails'
gem 'nokogiri'
gem 'octokit'
gem 'omniauth', '~> 1.9.1'
# gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-oauth2'
gem 'premailer-rails', '~> 1.11.1'
gem 'responders'

# gem 'omniauth-google-oauth2'
# gem 'google-api-client', require: 'google/api_client'

# gem 'activeadmin', github: 'activeadmin'
# gem 'activemodel-serializers-xml', github: 'rails/activemodel-serializers-xml'
# gem 'ckeditor'
gem 'dateslices'
gem 'draper'
gem 'formtastic', github: 'justinfrench/formtastic'
gem 'gretel'
# gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'kaminari', github: 'amatsuda/kaminari', branch: '0-17-stable'
# gem 'omniauth-twitter'
# gem 'ransack', github: 'activerecord-hackery/ransack'
# gem 'twitter'

ruby '~> 2.4'
