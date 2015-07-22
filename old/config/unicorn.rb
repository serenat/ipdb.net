# Unicorn config
working_directory "/var/www/vhosts/ipdb.net"
listen 8080 
worker_processes 10
pid "/var/www/vhosts/ipdb.net/tmp/pids/unicorn.pid"
user "rails", "rails"
stderr_path "/var/www/vhosts/ipdb.net/log/unicorn.log"
stdout_path "/var/www/vhosts/ipdb.net/log/unicorn.log"
