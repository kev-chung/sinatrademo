require 'sinatra'

get '/' do
  cakes = ""	
  File.open("cake.list").each_with_index do |line, index|
  	cakes += "#{index+1}. #{line}<br>"
  end
  cakes.to_s
end
