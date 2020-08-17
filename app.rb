require 'sinatra'

get '/' do
  File.open("cake.list").each_with_index do |line, index|
  	puts "#{index}. #{line}"
end
