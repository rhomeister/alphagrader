# frozen_string_literal: true

require 'dotenv'
# config valid only for Capistrano 3
lock '3.8.2'

set :user, 'deploy'
set :ssh_options, user: fetch(:user)

set :application, 'alphagrader'
set :ssl_cert_name, 'alphagrader'
set :repo_url, 'git@github.com:rhomeister/alphagrader.git'

set :pty, true

set :pg_extensions, %w(hstore unaccent)

set :memcached_ip, :all # make memcached listen to all IP addresses. The firewall blocks any unauthorized connection

# These settings are only useful when updating the SSL certificate using the "nginx:setup_ssl" task. This task will
# upload the local SSL certificate and key to the server.
set :nginx_ssl_cert_local_path, ".cert/#{fetch(:ssl_cert_name)}_bundle.crt"
set :nginx_ssl_cert_key_local_path, ".cert/#{fetch(:ssl_cert_name)}.key"

# enabled logrotate for unicorn logs
set :unicorn_logrotate_enabled, true

set :unicorn_env, 'RUBY_GC_MALLOC_LIMIT=100000000 LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1'

# define which roles are going to have a release installed. These are the app role, the roles that run Sidekiq and
# the role that runs the DB migrations
code_release_roles = -> { [:app, :worker, fetch(:migration_role)] }

set :rvm1_roles, code_release_roles # only install Ruby on release roles that are going to need the code
set :bundle_roles, code_release_roles # bundling is only necessary on nodes that have the Ruby code
set :memcached_roles, %i(app worker)
set :console_role, :worker

set :sidekiq_role, :worker
set :sidekiq_config, 'config/sidekiq.yml'
set :sidekiq_user, 'deploy'
set :sidekiq_default_hooks, false
after 'deploy:published', 'sidekiq:monit:restart' # restart using monit, not systemctl

set :assets_roles, %i(app worker db)

# split whenever scripts per environment (stage)
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :whenever_roles, [:db]

production_config = Dotenv::Parser.new(File.read('.env.production')).call
set :aws_access_key_id, production_config.fetch('S3_ACCESS_KEY')
set :aws_secret_access_key, production_config.fetch('S3_SECRET_KEY')
set :aws_region, production_config.fetch('S3_REGION')

before 'deploy', 'postgresql:database_yml_symlink'
before 'deploy:compile_assets', 'deploy:symlink:linked_dirs' # we need database.yml because asset_sync connects to DB
before 'deploy:compile_assets', 'deploy:symlink:linked_files'

# set :log_level, :info

before 'setup', 'rvm1:install:rvm'
before 'deploy', 'rvm1:install:ruby'

task :setup do
  invoke 'dotenv:setup'
  invoke 'sidekiq:monit:config'
end

namespace :rvm1 do # https://github.com/rvm/rvm1-capistrano3/issues/45
  desc 'Setup bundle alias'
  task :create_bundle_alias do
    on release_roles :all do
      execute %(echo "alias bundle='#{fetch(:rvm1_auto_script_path)}/rvm-auto.sh . bundle'" > ~/.bash_aliases)
    end
  end

  desc 'Install Bundler'
  task :install_bundler do
    on release_roles :all do
      execute "cd #{release_path} && #{fetch(:rvm1_auto_script_path)}/rvm-auto.sh . gem install bundler"
    end
  end
end
after 'rvm1:install:rvm', 'rvm1:create_bundle_alias'
after 'rvm1:install:ruby', 'rvm1:install_bundler'
