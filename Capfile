require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'capistrano/puma/nginx'
require 'capistrano/puma/monit'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
