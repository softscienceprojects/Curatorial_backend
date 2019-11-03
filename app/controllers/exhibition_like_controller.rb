class ExhibitionLikeController < ApplicationController
  def create
    exhibition_like = ExhibitionLike.create(exhibition_like_params)
    render json: exhibition_like
  end

  def destroy
    exhibition_like = exhibition_like.find(params[:id])
    exhibition_like.destroy
  end

  private

  def exhibition_like_params
    param.require(:exhibition_like).permit(:exhibition_id, :user_id)
  end
  
end
