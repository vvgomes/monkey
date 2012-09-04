require 'rubygems'
require 'bundler'
Bundler.require :default

get '/' do
  erb :index
end