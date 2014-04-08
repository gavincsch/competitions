require "bundler/capistrano"

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

#	Application
set :rails_env, "production" #added for delayed job  
set :application, "blair"


# Settings
set :deploy_to, "/var/www/blair.dev/"
set :deploy_via, :remote_cache
# set :use_sudo, true
default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true }

# Server - SEE CONFIG/DEPLOY/

# Source Code SEE CONFIG/DEPLOY/

namespace :deploy do

  #restart passenger after each deploy
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"

  end

  task :setup_config  do
    desc "Tasks for first setting up the app"
    #cap doesnt do this, so lets tell it to do it
    run "mkdir -p #{shared_path}/config"
    #create the database.yml on the server
    run "#{try_sudo} touch #{shared_path}/config/database.yml "
    puts "Now edit the database config in #{shared_path}."

  end

  after "deploy:setup", "deploy:setup_config"

  before "deploy:update_code", "deploy:change_ownership"

  task :change_ownership, roles: :app do
    run "#{try_sudo} chown -R #{user}:#{user} /var/www/blair.dev"
  end

  task :symlink_config, roles: :app do
    desc "Deploy the needed symlinks"
    run "cp #{shared_path}/config/database.yml #{release_path}/config/"
  end

  after "deploy:finalize_update", "deploy:symlink_config"

  task :reset_ownership, roles: :app do
    desc "Change ownership from deployer to www-data"
    run "#{try_sudo} chown -R www-data:www-data /var/www/blair.dev"
    run "#{try_sudo} chmod -R 777 #{release_path}/log"
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end

  after "deploy:assets:precompile", "deploy:reset_ownership"

  after "deploy:restart"

end
