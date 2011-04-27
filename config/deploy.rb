require 'bundler/capistrano'

default_run_options[:pty] = false
ssh_options[:forward_agent] = true
set :use_sudo, false
set :user, "godinaa"

set :application, "thesetimes.info"
set :repository,  "/home/godinaa/git/thesetimes.git"
set :scm, :git
set :branch, 'master'
set :git_shallow_clone, 1
set :deploy_via, :remote_cache
set :copy_compression, :bz2
set :rails_env, 'production'
set :deploy_to, "/home/godinaa/#{application}"

role :web, "#{application}"
role :app, "#{application}"
role :db,  "#{application}", :primary => true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end