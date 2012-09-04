require 'rubygems'
require 'bundler'
Bundler.require :default

get '/' do
  erb :index
end

post '/' do
  @data = params
  erb :index
end