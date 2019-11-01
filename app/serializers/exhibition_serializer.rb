class ExhibitionSerializer < ActiveModel::Serializer
  attributes :id, :summary, :description, :public
  #has_one :user
  belongs_to :user
  has_many :exhibition_likes
  has_many :artworks, through: :artwork_exhibitions
end
