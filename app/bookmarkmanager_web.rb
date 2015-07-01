require 'sinatra/base'
require_relative './models/link'
require_relative '../data_mapper_setup.rb'

class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    'Hello BookmarkManager!'
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  get '/links/new' do
    # form for submitting new links
    erb :new
  end

  post '/links' do
    link = Link.new
    link.title = params[:title]
    link.url = params[:url]
    tag = Tag.new
    tag.name = params[:tags]
    tag.save
    link.tags << tag
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :links
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
