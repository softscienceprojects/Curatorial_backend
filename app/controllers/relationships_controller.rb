class RelationshipsController < ApplicationController

    def create
        relationship = Relationship.create!(relationship_params)
        render json: relationship
    end

    def destroy
       relationship = Relationship.find(params[:id])
       relationship.destroy
       render json: relationship
    end

    private

    def relationship_params
        params.require(:relationship).permit(:follower_id, :followed_id)
    end
end
