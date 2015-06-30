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

  # start the server if ruby file executed directly
  run! if app_file == $0
end
