require 'data_mapper'
require 'dm-postgres-adapter'

env = ENV['RACK_ENV'] or 'development'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './app/models/link'

DataMapper.finalize

DataMapper.auto_upgrade!