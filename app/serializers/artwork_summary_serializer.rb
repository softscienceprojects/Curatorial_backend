class ArtworkSummarySerializer < ActiveModel::Serializer
  attributes :id, :artist, :title, :medium, :image_url, :content_names

end
