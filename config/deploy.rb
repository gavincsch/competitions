# Ensure that bundle is used for rake tasks
SSHKit.config.command_map[:rake] = "bundle exec rake"

# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'blair'
set :rails_env, "production"
set :repo_url, 'git@github.com:GavinCS/lead-gen.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/blair.dev/'
set :deploy_via, :remote_cache

# Default value for :scm is :git
#set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
#set :pty, false

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

# Default value for default_env is {}
#set :default_env, :production

## Default value for keep_releases is 5
set :keep_releases, 5

set(:config_files, %w(database.example.yml))

#set :tests, ["spec"]

namespace :deploy do


  desc "Change ownership to deployer"
  task :change_ownership  do
    on roles(:app) do
      execute :sudo, :chown, "-R #{fetch(:user)}:#{fetch(:user)} /var/www/blair.dev"
    end
  end

  before "deploy:starting", "deploy:change_ownership"
  #before "deploy:check:make_linked_dirs", "setup_config"


  desc "Change ownership from deployer to www-data"
  task :reset_ownership do
    on roles(:app) do
      execute :sudo, :chown, "-R www-data:www-data /var/www/blair.dev"
    end
  end

  after "deploy:finished", "deploy:reset_ownership"

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Restarts Phusion Passenger
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
