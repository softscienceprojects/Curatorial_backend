class ArtworkExhibitionsController < ApplicationController

  def index
    artwork_exhibitions = ArtworkExhibition.all
    render json: artwork_exhibitions
  end
  
end
