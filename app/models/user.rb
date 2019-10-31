class User < ApplicationRecord
    has_secure_password
    has_many :relationships

    has_many :follower_relationships, foreign_key: :following_id, class_name: "Relationship"
    has_many :followers, through: :follower_relationships, source: :follower_relationships

    has_many :following_relationships, foreign_key: :user_id, class_name: "Relationship"
    has_many :following, through: :following_relationships, source: :following

    has_many :exhibition_likes
    has_many :exhibitions

    #uncomment if reviews are implemented:
    #has_many :reviews

    has_one_attached :photo

     validates :email, uniqueness: true
     validates :password, presence: true
     validatees :password_confirmation, presence: true

end
