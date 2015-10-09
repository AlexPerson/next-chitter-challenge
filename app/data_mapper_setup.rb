require 'data_mapper'
require 'dm-validations'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

# require each model individually - the path may vary depending on your file structure.
require './app/models/user.rb'

DataMapper.finalize

DataMapper.auto_migrate!