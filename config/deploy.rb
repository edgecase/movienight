set :application, "movienight"

default_run_options[:pty] = true
set :scm, "git"
set :deploy_via, "remote_cache"
set :repository,  "git@github.com:railsrumble/rr09-team-69.git"
set :keep_releases, 5

set :user, 'deploy'
set :password, '2obscure'
set :deploy_to, "/var/www/movienight.railsrumble.com"

set :db_user, 'movie'
set :db_pass, '5ga8d7f5g$$'

role :app, "74.207.227.90"
role :web, "74.207.227.90"
role :db,  "74.207.227.90", :primary => true

# Override restart for passenger
namespace :deploy do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after 'deploy:update_code', :symlink_staging_configs
task :symlink_staging_configs, :role => :app do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end
