class ArtistsController < ApplicationController

  get '/artists' do
    @artists = Artist.all
    # binding.pry
    erb :'artists/index'
  end

  # get '/artists/:id' do
  #   @artist = Artist.find(params[:id])
  #   erb :'artists/show'
  # end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    # binding.pry
    erb :'artists/show'
  end

  delete "/artists/:id" do
    # binding.pry
    Artist.destroy(params[:id])
    redirect to "/artists"
  end


end
