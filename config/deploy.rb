# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'mickleberry.wedding'
set :repo_url, 'git@github.com:kenmickles/mickleberry.wedding.git'
set :deploy_to, '/home/deploy/mickleberry.wedding'
set :linked_files, %w{config/database.yml config/secrets.yml config/google_drive.json .env}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# rollbar
set :rollbar_token, ENV['ROLLBAR_ACCESS_TOKEN']
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :app }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end