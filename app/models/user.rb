class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, length: { minimum: 3, maximum: 20 }
  has_many :posts, foreign_key: "author_id", dependent: :destroy
  has_many :users_followers, dependent: :destroy, foreign_key: :user_id
  has_many :followers, through: :users_followers, source: :follower

  has_many :users_followings, dependent: :destroy, foreign_key: :follower_id, class_name: "UsersFollower"
  has_many :followings, through: :users_followings, source: :user
end
