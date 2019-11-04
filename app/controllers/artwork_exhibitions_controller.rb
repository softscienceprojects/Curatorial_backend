class ArtworkExhibitionsController < ApplicationController

  def index
    artwork_exhibitions = ArtworkExhibition.all
    render json: artwork_exhibitions, :include => [:artwork, :exhibition]
  end
  
  def create
    add_to_show = ArtworkExhibition.create!(artwork_exhibitions_params)
    render json: add_to_show, :include => :exhibition #Exhibition.find(params[:artwork_exhibition][:exhibition_id])
  end

  def destroy
    artwork_to_destroy = ArtworkExhibition.destroy(params[:id])
    render json: artwork_to_destroy, :include => :artwork
  end


  private

  def artwork_exhibitions_params
    params.require(:artwork_exhibition).permit(:artwork_id, :exhibition_id)  
  end
end
