namespace :rails do
  task :setup_console do # setup a clear prompt
    irbrc = %q(
      env_string = Rails.env

      unless Rails.env.development?
        env_string = "\e[31;1;5m#{env_string}\e[0m"
      end

      IRB.conf[:PROMPT][:RAILS_ENV] = {
          :PROMPT_I => "#{Rails.application.class.parent_name} #{env_string}> ",
          :PROMPT_N => "#{Rails.application.class.parent_name} #{env_string}> ",
          :PROMPT_S => nil,
          :PROMPT_C => "?> ",
          :RETURN => "=> %s\n"
      }

      IRB.conf[:PROMPT_MODE] = :RAILS_ENV
    )

    on primary :app do
      upload! StringIO.new(irbrc), '/home/deploy/.irbrc'
    end
  end

  desc 'Remote console'
  task :console do
    on primary fetch(:console_role) do |h|
      run_interactively "bundle exec rails console -e #{fetch(:rails_env)}", h.user
    end
  end
  before 'rails:console', 'rails:setup_console'

  desc 'Remote dbconsole'
  task :dbconsole do
    on primary fetch(:console_role) do |h|
      run_interactively "bundle exec rails dbconsole #{fetch(:rails_env)}", h.user
    end
  end

  desc 'SSH console'
  task :ssh_console do
    # role = ENV['CAP_ROLE'] || :console
    on primary fetch(:console_role) do |_h|
      run_interactively '/bin/bash', 'root'
    end
  end

  def run_interactively(command, user)
    user ||= fetch(:user)
    info "Running `#{command}` as #{user}@#{host}"
    exec %(ssh #{user}@#{host} -t "bash --login -c 'cd #{fetch(:deploy_to)}/current && #{command}'")
  end
end
