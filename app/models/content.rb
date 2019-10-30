class Content < ApplicationRecord

    has_many :artwork_contents
    has_many :artworks, through: :artwork_contents

    
end
