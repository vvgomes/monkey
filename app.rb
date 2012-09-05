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
  deploy if @@last[:status] == 'Passed'
end

def deploy
  begin
    `git clone --depth=100 --quiet git://github.com/vvgomes/victorykit.git` if Dir['victorykit'].empty?
    `cd victorykit`
    `git pull`
    `git checkout -qf #{@@last[:commit]}`
    `git remote add testserver git@heroku.com:still-retreat-5611.git`
    `git push testserver #{@@last[:branch]}`
  rescue => e
    puts "Bad news: #{e}"
    return 1
  end  
  0
end
