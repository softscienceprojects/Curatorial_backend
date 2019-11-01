class Exhibition < ApplicationRecord
  belongs_to :user

  has_many :artwork_exhibitions
  has_many :artworks, through: :artwork_exhibitions

  has_many :exhibition_likes

  #has_many :reviews

  has_one_attached :photo
  validates :user_id, presence: true
  validates :summary, presence: true
  

end
