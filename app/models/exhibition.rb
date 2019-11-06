class Exhibition < ApplicationRecord
  belongs_to :user

  has_many :artwork_exhibitions, dependent: :destroy
  has_many :artworks, through: :artwork_exhibitions

  has_many :exhibition_likes, dependent: :destroy
  has_many :users, through: :exhibition_likes

  #has_many :reviews

  has_one_attached :photo
  validates :user_id, presence: true
  validates :title, presence: true
  validates :summary, presence: true, length: {maximum: 200}
  

end
