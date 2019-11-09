class RelationshipsController < ApplicationController

    def create
        relationship = Relationship.create!(relationship_params)
        render json: relationship.to_json(:include=> {
            :followed_user => {:only => [:id, :first_name, :last_name, :biography], :include=>[:exhibitions]}
        })
    end

    def destroy
       relationship = Relationship.find(params[:id])
       relationship.destroy
       render json: relationship.to_json(:include=> {
           :followed_user => {:only => [:id, :first_name, :last_name, :biography], :include=>[:exhibitions]}
        })
    end

    private

    def relationship_params
        params.require(:relationship).permit(:follower_id, :followed_id)
    end
end
