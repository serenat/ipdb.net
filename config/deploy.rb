lock '3.4.0'

set :application, "ipdb"
set :repo_url, 'git@github.com:serenat/ipdb.net.git'
set :deploy_via, :remote_cache

set :user, 'deploy'
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :keep_releases, 5

set :stage, :production

set :rbenv_type, :system
set :rbenv_ruby, '2.2.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :puma_init_active_record, true
set :puma_monit_conf_dir, -> { "/etc/monit/conf.d/#{puma_monit_service_name}.monitrc" }

after "deploy:started", "figaro:setup"
after "deploy:updating", "figaro:symlink"
after "deploy:finishing", "deploy:restart"
after 'deploy:finished', 'puma:nginx_config'
after 'deploy:finished', 'puma:monit:config'
