
namespace :dotenv do
  desc 'Setup the .env file'
  task :setup do
    on release_roles :all do
      name = ".env.#{fetch(:stage)}"
      file = File.open(name)
      destination = shared_path.join(name)
      execute :mkdir, '-pv', File.dirname(destination)
      upload! file, destination
    end
  end

  task :symlink do
    name = ".env.#{fetch(:stage)}"
    set :linked_files, fetch(:linked_files, []).push(name)
  end
  before 'deploy:symlink:linked_files', 'dotenv:symlink'
end
