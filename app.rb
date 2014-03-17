require 'sinatra'
require 'sass'
require 'sinatra/activerecord'
require './config/environments'
require './models/post'

require 'pp' # Temp

before do
  test_config_file
  @user = get_name
  @theme = get_theme[0]
  @title_font = get_theme[1]
  @body_font = get_theme[2]
end

get '/css/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  filename = params[:name]
  render :scss, filename.to_sym, :layout => false, :views => './public/css/sass'
end

get '/' do
  erb :index
end

# Posts
get '/:user/posts' do
  @posts = Post.where(owner: params[:user], private: false).order('id DESC')
  erb :'post/index'
end

get '/post/show/:id' do
  @post = Post.find(params[:id])
  erb :'post/show'
end

get '/post/new' do
  erb :'post/new'
end

get '/post/edit/:id' do
  @post = Post.find(params[:id])
  erb :'post/edit'
end

post '/post/create' do
  @_post = params[:post]
  assign_values

  @post = Post.new(@_post)
  
  if @post.save
    @message = 'Post successfully created.'
    erb :'admin/index'
  else
    @message = 'Failed to save post.'
    erb :'admin/index'
  end
end

post '/post/update/:id' do
  @_post = params[:post]
  assign_values

  @post = Post.find(params[:id])

  if @post.update_attributes(@_post)
    @message = 'Post successfully updated.'
    erb :'admin/index'
  else
    @message = 'Failed to update post.'
    erb :'admin/index'
  end
end

get '/post/destroy/:id' do
  Post.find(params[:id]).destroy
  @message = "Deleted post ##{params[:id]}"
  erb :'admin/index'
end
#

# Tags
get '/tagged/:tag' do
  erb :index
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

helpers do
  def test_config_file
    begin
      File.open('config/theme.conf', 'r') do |f|
      end
    rescue
      File.open('config/theme.conf', 'w') do |f|
        f.write("test\nsimple Alike+Angular Anaheim")
      end
    end
  end

  def get_name
    File.open('config/theme.conf', 'r') do |f|
      f.each_line do |line|
        return line
      end
    end
  end

  def get_theme
    File.open('config/theme.conf', 'r') do |f|
      (2-1).times { f.gets }
      return f.gets.split(' ')
    end
  end

  def format_tags(tags)
    if tags =~ /(, )+/
      tags = tags.split ', '
      tags.each_with_index do |t,i|
        tags[i] = "<a href=\"/tagged/#{t}\">#{t}</a>"
      end
    else
      tags = "<a href=\"/tagged/#{tags}\">#{tags}</a>"
    end
    tags
  end

  def destroy_post_link(post)
    "<p class=\"destroy\"><a href=\"/post/destroy/#{post.id}\" title=\"Delete post ##{post.id}\"></a></p>" if post.owner == @user
  end

  def assign_values
    @_post['private'] = '0' if @_post['private'] != '1'
    @_post['owner'] = @user
    @_post['likes'] = '0'
    @_post['date'] = Time.new
  end

  def set_form_path(obj, name)
    if obj
      "/#{name}/update/#{obj.id}"
    else
      "/#{name}/create"
    end
  end
end
