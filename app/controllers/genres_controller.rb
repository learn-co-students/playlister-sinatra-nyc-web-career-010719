class GenresController < ApplicationController

  get '/genres' do
    @genres = Genre.all
    erb :'genres/index'
  end

  get '/genres/:slug' do
    @genre = Genre.find_by_slug(params[:slug])
    erb :'genres/show'
  end

  delete "/genres/:id" do
    # binding.pry
    Genre.destroy(params[:id])
    redirect to "/genres"
  end


end
