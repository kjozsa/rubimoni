require 'rubygems'
require 'bundler'
require 'logger'
Bundler.require

# config values
$refresh = 60
$watch_mins = 120

# O/R mapper
require './app/entities'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite3:data.db")
DataMapper.finalize
begin
  Target.first 
rescue
  DataMapper.auto_migrate!   # this will migrate schema and erase everything
end

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

