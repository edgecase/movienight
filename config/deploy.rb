set :application, "movienight"

default_run_options[:pty] = true
set :scm, "git"
set :deploy_via, "remote_cache"
set :repository,  "git@github.com:mattyoho/movienight.git"
set :keep_releases, 5

set :user, 'mbyoho'
set :password, 'NOPE'
set :deploy_to, "/var/www/movienight.com"

set :db_user, 'mbyoho'
set :db_pass, 'NOPE'

role :app, "206.71.169.122"
role :web, "206.71.169.122"
role :db,  "206.71.169.122", :primary => true

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
