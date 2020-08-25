require 'sinatra'
require 'sinatra/json'
require 'pg'
require 'sinatra/activerecord'

get '/' do
  erb :index
end

get '/cake/:id' do
  begin	
    connection = PG.connect :dbname => Sinatra::Application.environment == "production" ? ENV['DATABASE_URL'] : 'cakedb'
    @id = params[:id]
    query_result = connection.exec "SELECT cake FROM cakes WHERE id = '#{params[:id]}';"
    @cake = query_result.getvalue(0,0)

  rescue PG::Error => e
    puts e.message.to_s

  ensure
  	connection.close if connection
  end

  erb :cake
end

get '/cakes.json' do
  begin	
    connection = PG.connect :dbname => Sinatra::Application.environment == "production" ? ENV['DATABASE_URL'] : 'cakedb'
    cake_list = connection.exec "SELECT * FROM cakes;"

  rescue PG::Error => e
    puts e.message.to_s

  ensure
  	connection.close if connection
  end

  json cake_list.map{ |row| {:id => row['id'], :cake => row['cake']} }

end

post '/add_cake' do
  begin
    connection = PG.connect :dbname => Sinatra::Application.environment == "production" ? ENV['DATABASE_URL'] : 'cakedb'
    connection.exec "INSERT INTO cakes(cake, created_at, updated_at) VALUES ('#{params[:newCake]}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);"

  rescue PG::Error => e
  	puts e.message.to_s

  ensure
  	connection.close if connection
  end

  redirect '/'

end

post '/edit_cake/:id' do
  begin
    connection = PG.connect :dbname => Sinatra::Application.environment == "production" ? ENV['DATABASE_URL'] : 'cakedb'
    connection.exec "UPDATE cakes SET cake = '#{params[:updateCake]}', updated_at = CURRENT_TIMESTAMP WHERE id = #{@params[:id]};"

  rescue PG::Error => e
  	puts e.message.to_s

  ensure
  	connection.close if connection
  end

  redirect '/'
end

post '/delete_cake/:id' do
  begin
    connection = PG.connect :dbname => Sinatra::Application.environment == "production" ? ENV['DATABASE_URL'] : 'cakedb'
    connection.exec "DELETE FROM cakes WHERE id = #{@params[:id]};"

  rescue PG::Error => e
  	puts e.message.to_s

  ensure
  	connection.close if connection
  end

  redirect '/'
end

