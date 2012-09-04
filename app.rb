require 'rubygems'
require 'bundler'
Bundler.require :default

get '/' do
  erb :index
end

post '/' do
  payload = params['payload']
  puts ">>>>>>>>>> FOO: #{payload['status_message']}"
  puts ">>>>>>>>>> FOO: #{payload['commit']}"
  puts ">>>>>>>>>> FOO: #{payload['brunch']}"

  'done'
end
