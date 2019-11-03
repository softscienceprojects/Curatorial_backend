class ArtworkExhibitionsController < ApplicationController

  def index
    artwork_exhibitions = ArtworkExhibition.all
    render json: artwork_exhibitions
  end
  
  def create
    add_to_show = ArtworkExhibition.create!(artwork_exhibitions_params)
    render json: add_to_show, :include => :exhibition #Exhibition.find(params[:artwork_exhibition][:exhibition_id])
  end

  def destroy
    
  end


  private

  def artwork_exhibitions_params
    params.require(:artwork_exhibition).permit(:artwork_id, :exhibition_id)  
  end
end
