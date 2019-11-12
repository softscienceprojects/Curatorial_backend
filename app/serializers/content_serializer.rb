class ContentSerializer < ActiveModel::Serializer
  attributes :id, :description, :artworks

  def artworks
    self.object.artworks.map do |a|
      ArtworkSummarySerializer.new(a)
    end
  end
end
