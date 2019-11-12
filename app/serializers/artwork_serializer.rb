class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :artist, :title, :medium, :description, :collection, :location, :image_url, :image_copyright, :permalink, :origin_id, :content_names

  has_many :exhibitions

end
