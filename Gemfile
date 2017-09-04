# frozen_string_literal: true
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Unicorn as the app server
gem 'unicorn'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
#
gem 'haml'

gem 'paperclip', '~> 5.0'
gem 'aws-sdk', '~> 2.3.0'
gem 'rubyzip'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'redis-namespace'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'simple_form'

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
  gem 'pry'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'letter_opener'
  gem 'happy_seed'

  gem 'rubocop', require: false
  gem 'brakeman', require: false

  # capistrano

  gem 'capistrano', '~> 3.8', require: false, group: :development
  # Deploy with capistrano, see config/deploy.rb
  gem 'capistrano-rails', '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-safe-deploy-to', '~> 1.1.1', require: false
  gem 'rvm1-capistrano3', '~> 1.3.2', require: false
  gem 'capistrano-postgresql', '~> 4.2.1', require: false
  # gem 'capistrano-memcached', '~> 1.2.0', require: false
  gem 'capistrano-unicorn-nginx', '~> 4.1', require: false
  # gem 'capistrano-faster-assets', '~> 1.0.2', require: false
  gem 'capistrano-sidekiq', require: false
end

group :test do
  gem 'rspec-rails'
  gem 'rspec-mocks'
  gem 'spring-commands-rspec'
  gem 'rspec-collection_matchers'
  gem 'vcr'
  gem 'webmock'
  gem 'rails-controller-testing'
  gem 'capybara'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'bootstrap-sass'
gem 'modernizr-rails'
gem 'meta-tags', require: 'meta_tags'
gem 'responders', '~> 2.0'
gem 'bh'
gem 'premailer-rails'
gem 'nokogiri'
gem 'devise', '~> 4.2'
gem 'cancancan'
gem 'omniauth'
gem 'omniauth-oauth2', '1.3.1'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'octokit'
gem 'github_webhook', '~> 1.0.2'

gem 'omniauth-google-oauth2'
# gem 'google-api-client', require: 'google/api_client'

gem 'omniauth-twitter'
gem 'twitter'
gem 'ckeditor'
gem 'activeadmin', github: 'activeadmin'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'ransack', github: 'activerecord-hackery/ransack'
gem 'kaminari', github: 'amatsuda/kaminari', branch: '0-17-stable'
gem 'formtastic', github: 'justinfrench/formtastic'
gem 'draper', github: 'audionerd/draper', branch: 'rails5', ref: 'e816e0e587'
gem 'activemodel-serializers-xml', github: 'rails/activemodel-serializers-xml'
gem 'dateslices'
gem 'gretel'

ruby '2.3.1'
