class Artwork < ApplicationRecord

    has_many :artwork_exhibitions
    has_many :exhibitions, through: :artwork_exhibitions

    has_many :artwork_contents
    has_many :contents, through: :artwork_contents


    
end
