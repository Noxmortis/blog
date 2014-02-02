require 'sinatra'
require 'sass'
require 'sinatra/activerecord'
require './config/environments'
require './models/post'

before do
  @theme = 'base'
  @username = 'noxmortis'
end

get '/css/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  filename = params[:name]
  render :scss, filename.to_sym, :layout => false, :views =>'./public/css/sass'
end

get '/' do
  erb :index
end

get '/admin' do
  erb :'admin/index'
end

not_found do
  status 404
  erb :notfound
end
