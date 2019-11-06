class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :artist, :title, :medium, :description, :collection, :location, :image_url, :image_copyright, :permalink, :origin_id, :artwork_exhibitions, :contents
  has_many :contents, through: :artwork_contents

  has_many :artwork_contents
  has_many :contents, through: :artwork_contents
  has_many :exhibitions, through: :artwork_exhibitions
  has_many :artwork_exhibitions

  def artworks_contents
    object.artwork_contents.each do |artcontent|
       artcontent
    end
  end

end
