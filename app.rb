require 'rubygems'
require 'bundler'
Bundler.require :default

Mongoid.configure do |config|
  if ENV['MONGOHQ_URL']
    conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    uri = URI.parse(ENV['MONGOHQ_URL'])
    config.master = conn.db(uri.path.gsub(/^\//, ''))
  else
    begin
      config.master = Mongo::Connection.
        from_uri('mongodb://127.0.0.1:27017').
        db('semprenalista')
    rescue
      puts 'No DB.'
    end
  end
end

get '/' do
  erb :index
end

post '/' do
  puts ">>> OK, got there"
  raw = params['payload']
  puts ">>> CLASS: #{raw.class}"
  puts ">>> STATUS: #{raw['status_message']}"
  puts ">>> COMMIT: #{raw['commit']}"
  puts ">>> BRANCH: #{raw['branch']}"
  Payload.create(
    :status_message => raw['status_message'], 
    :commit => raw['commit'],
    :branch => raw['branch'])
  'done'
end

class Payload
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status_message, :type => String
  field :commit, :type => String
  field :branch, :type => String
end
