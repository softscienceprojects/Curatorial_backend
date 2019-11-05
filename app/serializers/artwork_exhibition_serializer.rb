class ArtworkExhibitionSerializer < ActiveModel::Serializer
  attributes :id, :artwork_id, :exhibition_id
  belongs_to :artwork
  belongs_to :exhibition
end
