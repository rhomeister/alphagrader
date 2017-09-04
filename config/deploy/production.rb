# frozen_string_literal: true

set :stage, :production
set :rails_env, fetch(:stage) # set the rails environment

set :branch, 'capistrano'

ansible_roles('config/ansible/production_linode') # load roles from ansible repository

set :migration_role, :db # the primary (first) DB performs the migrations
set :pg_host, primary(:db).hostname # setting the host name of PostgreSQL in the database.yml config

set :unicorn_workers, 2 # run two unicorn workers per app server

set :memcached_memory_limit, 128

set :nginx_upload_local_cert, true # set this to true when there is a new SSL certificate
set :nginx_use_http2, true
set :nginx_use_ssl, true
set :nginx_pass_ssl_client_cert, true # pass the client SSL certificate to the ruby code
set :nginx_fail_timeout, 0
