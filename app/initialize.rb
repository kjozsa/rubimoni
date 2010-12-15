require 'rubygems'
require 'bundler'
require 'logger'
Bundler.require

# config
$refresh = 60
$watch_mins = 120

# O/R mapper
require './app/entities'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite::memory:')
DataMapper.finalize
DataMapper.auto_migrate!

# monitor
require './app/monitor'
$monitor = Monitor.new

# scheduler
require 'rufus/scheduler'
$scheduler ||= Rufus::Scheduler.start_new
$scheduler.every "#{$refresh}s" do 
  $monitor.monitor
end

# web ui
require './app/webui'
set :public, File.dirname(__FILE__) + '/../static'
set :views, File.dirname(__FILE__) + '/../views'

