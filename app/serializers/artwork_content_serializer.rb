class ArtworkContentSerializer < ActiveModel::Serializer
  attributes :id, :artwork_id, :content_id, :score, :confidence, :topicality
  belongs_to :content
  belongs_to :artwork
end
