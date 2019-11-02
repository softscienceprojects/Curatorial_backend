class RelationshipController < ApplicationController

    def index
        
    end

    def create
        relationship = Relationship.create!(relationship_params)
    end

    def destroy

    end

    private

    def relationship_params
        params.require(:relationship).permit(:follower)
    end
end
