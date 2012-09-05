require 'rubygems'
require 'bundler'
Bundler.require :default

@@last = {
  :status => "don't know", 
  :commit => "wasn't watching it",
  :branch => "master maybe?"
}

get '/' do
  erb :index
end

post '/' do
  raw = JSON.parse(params[:payload])
  @@last = {
    :status => raw['status_message'], 
    :commit => raw['commit'],
    :branch => raw['branch']
  }
  'done'
end
