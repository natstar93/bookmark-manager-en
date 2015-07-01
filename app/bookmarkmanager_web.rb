require 'sinatra/base'
require_relative './models/link'
require_relative '../data_mapper_setup.rb'

class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    'Hello BookmarkManager!'
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
    #form for registering new users
    erb :'users/new'
  end

  post '/users' do
    User.create(email: params[:email],
      password: params[:password])
    redirect to('/links')
    session[:user_id] = user.user_id
    redirect to('/')
  end
  
  helpers do
    def current_user
      user ||= User.first(id: session[:user_id]) 
    end

  end





  # start the server if ruby file executed directly
  run! if app_file == $0
end
