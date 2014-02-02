require 'sinatra'
require 'sass'
require 'sinatra/activerecord'
require './config/environments'
require './models/post'

before do
  @username = 'noxmortis'
  @theme = 'simple'
  @title_font = 'Alike+Angular'
  @body_font = 'Anaheim'
end

get '/css/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  filename = params[:name]
  render :scss, filename.to_sym, :layout => false, :views =>'./public/css/sass'
end

get '/' do
  erb :index
end

# Posts
get '/post' do
  @posts = Post.all
  erb :'post/index'
end

get '/post/:id' do
  erb :'post/show'
end

get 'post/edit/:id' do
  erb :'post/edit'
end

post 'post/create' do
  
end

post 'post/update' do

end

get 'post/destroy/:id' do

end
#

# Admin
get '/admin' do
  erb :'admin/index'
end
#

# Temp
get '/seed' do
  Post.create(title: 'Blog 1', owner: 'noxmortis', date: '2014-02-01 21:00:00', content: 'This is the content', tags: 'test, tag', likes: 23, private: 0)
end

not_found do
  status 404
  erb :notfound
end
