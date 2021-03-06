require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm' #rbenv
# require 'mina/whenever'

set :domain, '123.57.255.15'
set :branch, 'master'

set :user, 'deploy'
set :forward_agent, true
set :port, 9527

set :deploy_to, '/home/deploy/thin-deploy'
set :current_path, 'current'
set :app_path,  "#{deploy_to}/#{current_path}"

set :repository, 'git@gitlab.com:hunter/thin-deploy.git'
set :keep_releases, 5

set :thin_pid, lambda { "#{deploy_to}/#{shared_path}/tmp/pids/thin.pid" }
set :thin_pids_filder, lambda { "#{deploy_to}/#{shared_path}/tmp/pids/" }

set :shared_paths, [
  'config/database.yml',
  'config/application.yml',
  'tmp',
  'log'
]

task :environment do
  queue! 'source ~/.bashrc'
  invoke :'rvm:use[ruby-2.2.0]'
end

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue! %[touch "#{deploy_to}/shared/config/application.yml"]
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:cleanup'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    queue! %{
      cd "#{app_path}"
      bundle exec rake db:migrate RACK_ENV=production
    }

    queue! %{
      cd "#{app_path}"
      bundle exec rake assets:precompile RACK_ENV=production
    }

    to :launch do
      invoke :'thin:restart'
      queue "touch #{deploy_to}/tmp/restart.txt"
    end
  end
end

namespace :thin do
  desc "Start thin"
  task start: :environment do
    queue 'echo "-----> Start thin"'
    queue! %{
      cd #{app_path}
      bundle exec thin -p 9000 -e production -d start
    }
  end

  desc "Stop thin"
  task stop: :environment do
    queue 'echo "-----> Stop thin"'
    queue! %{
      test -s #{thin_pid} && kill -QUIT `cat "#{thin_pid}"` && cd #{thin_pids_filder} && rm * && echo "-----> Stop Ok" && exit 0
      echo >&2 "Not running"
    }
  end

  desc "Restart thin"
  task restart: :environment do
    invoke :'thin:stop'
    invoke :'thin:start'
  end
end