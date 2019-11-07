class ArtworksController < ApplicationController

    def index
        artworks = Artwork.all 
        render json: artworks
    end

    def explore
        offset = rand(Artwork.count)
        rand_records = Artwork.offset(offset).limit(5)
        render json: rand_records
    end

    def show
        artwork = Artwork.find(params[:id])
        render json: artwork
    end
end
