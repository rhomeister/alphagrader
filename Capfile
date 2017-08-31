# frozen_string_literal: true
# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

require 'capistrano/safe_deploy_to'

require 'capistrano/postgresql'

require 'capistrano/unicorn_nginx'

# require 'capistrano/memcached'

# require 'whenever/capistrano'

# Includes tasks from other gems included in your Gemfile
require 'capistrano/bundler'
require 'capistrano/rails'

require 'rvm1/capistrano3'

# require 'capistrano/faster_assets'

# require 'capistrano/wal_e'

require 'capistrano/sidekiq'
require 'capistrano/sidekiq/monit'

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
