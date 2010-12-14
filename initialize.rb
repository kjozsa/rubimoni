require 'rubygems'
require 'bundler'
Bundler.require

require './rubimoni'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite::memory:')
DataMapper.finalize
DataMapper.auto_migrate!

set :public, File.dirname(__FILE__) + '/static'
set :views, File.dirname(__FILE__) + '/views'

