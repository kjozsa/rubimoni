require 'rubygems'
require 'bundler'
require 'logger'
Bundler.require

# O/R mapper
require './entities'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite::memory:')
DataMapper.finalize
DataMapper.auto_migrate!

# monitor
require './monitor'
$monitor = Monitor.new

# scheduler
require 'rufus/scheduler'
$scheduler ||= Rufus::Scheduler.start_new
$scheduler.every '30s' do 
  $monitor.monitor
end

# web ui
require './webui'
set :public, File.dirname(__FILE__) + '/static'
set :views, File.dirname(__FILE__) + '/views'

