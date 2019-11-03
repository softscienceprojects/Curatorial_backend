class User < ApplicationRecord
    has_secure_password
    has_many :relationships

    #follower is doing the following
    #followed is who is being followed by the follower 
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :followed_users, through: :active_relationships, source: :followed_user
    has_many :follower_users, through: :passive_relationships, source: :follower_user

    has_many :exhibition_likes
    has_many :exhibitions

    #uncomment if reviews are implemented:
    #has_many :reviews

    has_one_attached :photo

     validates :email, uniqueness: true, on: :create
     validates :password, presence: true, on: :create
     validates :password_confirmation, presence: true, on: :create

end
