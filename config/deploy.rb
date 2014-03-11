# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'quizapp'
set :repo_url, 'git@bitbucket.org:jankraus/quizapp.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/quizapp'
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache

set :format, :pretty
set :log_level, :debug
set :pty, true

set :use_sudo, false
set :rails_env, "production"

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml}
# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  #after :restart, :clear_cache do
  #  on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
  #  end
  #end


  desc 'Runs rake db:seed if migrations are set'
  task :db_seed do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc 'Runs rake db:migrate'
  task :db_migrate do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:migrate"
        end
      end
    end
  end

end
