class ArtworkContentController < ApplicationController
  def index
    artworks= ArtworkContent.all
    render json: artworks
  end
end
