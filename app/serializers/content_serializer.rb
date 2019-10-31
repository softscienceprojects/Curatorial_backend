class ContentSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_many :artworks, through: :artwork_contents
end
