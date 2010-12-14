require 'rubygems'
require 'bundler'
require 'logger'
Bundler.require

require './entities'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite::memory:')
DataMapper.finalize
DataMapper.auto_migrate!

require './monitor'
Monitor.new

require './rubimoni'
set :public, File.dirname(__FILE__) + '/static'
set :views, File.dirname(__FILE__) + '/views'

