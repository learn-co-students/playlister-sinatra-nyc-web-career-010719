require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash
  enable :sessions

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  post '/songs' do
    # binding.pry
    @artist_name = params["Artist Name"]
    @artist = Artist.find_or_create_by(name: @artist_name)
    @artist.name = @artist_name
    @song = Song.create(name: params["Name"], artist_id: @artist.id)
    @genre_ids = params[:genres]
    @genres = @genre_ids.map do|genre_id|
      Genre.find(genre_id)
    end
    @song.genres = @genres
    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    erb :'songs/show'
  end

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    # binding.pry
    @song = Song.find_by(name: params[:song][:name])
    @artist = @song.artist
    # binding.pry
    @song.update(name: params[:song][:name], artist_id: @artist.id)
    @genres = params[:song][:genres].map do|genre_id|
      Genre.find(genre_id)
      end
    # binding.pry
    @song.genres = @genres

    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end

end
