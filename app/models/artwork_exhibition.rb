class ArtworkExhibition < ApplicationRecord
  belongs_to :exhibition
  belongs_to :artwork
end
