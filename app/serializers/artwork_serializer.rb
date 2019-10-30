class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :artist, :title, :medium, :description, :collection, :location, :image_url, :image_copyright, :permalink, :origin_id
  has_many :artwork_contents
  has_many :contents, through: :artwork_contents
end
