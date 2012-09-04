require 'rubygems'
require 'bundler'
Bundler.require :default

get '/' do
  erb :index
end

post '/' do
  puts ">>>>>>>>>> THE PARAMS: #{params}"
  'done'
end
