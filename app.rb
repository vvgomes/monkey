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
  clone = "git clone --depth=100 --quiet git://github.com/vvgomes/victorykit.git"
  cd = 'cd victorykit'
  pull = 'git pull'
  checkout = "git checkout -qf #{@@last[:commit]}"
  add_remote = 'git remote add testserver git@heroku.com:still-retreat-5611.git'
  push = "git push testserver #{@@last[:branch]}"
  begin
    `#{clone}` if Dir['victorykit'].empty?
    `#{cd} && #{pull} && #{checkout} && #{add_remote} && #{push}`
  rescue => e
    puts "Bad news: #{e}"
    return 1
  end  
  0
end
