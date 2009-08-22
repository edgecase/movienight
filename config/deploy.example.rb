set :application, "movienight"

default_run_options[:pty] = true
set :scm, "git"
set :deploy_via, "remote_cache"
set :repository,  "git@github.com:railsrumble/rr09-team-69.git"
set :keep_releases, 5

set :user, ''
set :password, ''
set :deploy_to, "/var/www/movienight.railsrumble.com"

set :db_user, ''
set :db_pass, ''

role :app, "74.207.227.90"
role :web, "74.207.227.90"
role :db,  "74.207.227.90", :primary => true
