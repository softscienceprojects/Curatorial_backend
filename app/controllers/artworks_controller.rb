class ArtworksController < ApplicationController

    def index
        artworks = Artwork.all # .limit(3) - for limiting, need to also randomise
        render json: artworks
    end

    def show
        artwork = Artwork.find(params[:id])
        render json: artwork
    end
end
