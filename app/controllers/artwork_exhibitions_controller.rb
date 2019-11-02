class ArtworkExhibitionsController < ApplicationController

  def index
    artwork_exhibitions = ArtworkExhibition.all
    render json: artwork_exhibitions
  end
  
  def create
    add_to_show = ArtworkExhibition.create!(artwork_exhibitions_params)
    render json: add_to_show
  end

  def destroy
    
  end


  private

  def artwork_exhibitions_params
    params.require(:artwork_exhibitions).permit(:exhibition_id, :artwork_id)  
  end
end
