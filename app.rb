require 'sinatra'
require 'sinatra/json'

get '/' do
  erb :index
end

get '/cakes.json' do
  json File.open("cake.list").lines.map{ |line| {:cake => line.strip} }
end

