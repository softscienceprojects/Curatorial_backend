class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :artist, :title, :medium, :description, :collection, :location, :image_url, :image_copyright, :permalink, :origin_id
  has_many :contents, through: :artwork_contents

  has_many :artworks_contents
  has_many :exhibitions, through: :artwork_exhibitions

  def artworks_contents
    object.artwork_contents.each do |artcontent|
       artcontent
    end
  end

end
