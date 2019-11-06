class ArtworkContentSerializer < ActiveModel::Serializer
  attributes :id, :artwork_id, :content_id, :score, :confidence, :topicality, :artwork, :content
  belongs_to :content
  belongs_to :artwork
end
