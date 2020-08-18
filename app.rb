require 'sinatra'

get '/' do
  cakes = "<ol>"	
  File.open("cake.list").each do |line|
  	cakes += "<li>#{line}</li>"
  end
  cakes.to_s + "</ol>"
end
