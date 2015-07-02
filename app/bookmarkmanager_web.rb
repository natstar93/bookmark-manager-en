require 'sinatra/base'
require 'sinatra/flash'
require 'launchy'
require_relative './models/link'
require_relative './models/user'
require_relative '../data_mapper_setup.rb'

class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/' do
    'Hello BookmarkManager!'
    erb :'index'
  end

  get '/links' do
    @links = Link.all
    erb :'links/links'
  end

  get '/links/new' do
    # form for submitting new links
    erb :'links/new'
  end

  post '/links' do
    link = Link.new
    link.title = params[:title]
    link.url = params[:url]

    multi_tag = params[:tags].split
    multi_tag_count = multi_tag.count

    multi_tag_count.times do
      tag = Tag.new
      tag.name = multi_tag.shift
      tag.save
      link.tags << tag
    end

    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/links'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(email: params[:email],
      password: params[:password], password_confirmation: params[:password_confirmation])

    if @user.save 
        session[:user_id] = @user.id
        redirect to('/links')
    else
        #flash.now[:notice]="Password and confirmation password do not match"
        flash.now[:errors] = @user.errors.full_messages
        erb :'users/new'
    end
  end
  
  helpers do
    def current_user
      @user ||= User.first(id: session[:user_id])
    end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
