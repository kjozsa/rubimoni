require 'net/http'
require 'sinatra'
require 'haml'
require './rubimoni'

set :public, File.dirname(__FILE__) + '/static'

run Sinatra::Application

