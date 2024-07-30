class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, length: { minimum: 3, maximum: 20 }
  has_many :posts, foreign_key: "author_id", dependent: :destroy

  # followers
  has_many :users_followers, dependent: :destroy, foreign_key: :user_id
  has_many :followers, through: :users_followers, source: :follower

  has_many :pending_followers, -> { UsersFollower.pending }, through: :users_followers, source: :follower
  has_many :accepted_followers, -> { UsersFollower.accepted }, through: :users_followers, source: :follower
  has_many :denied_followers, -> { UsersFollower.denied }, through: :users_followers, source: :follower

  # followings
  has_many :users_followings, dependent: :destroy, foreign_key: :follower_id, class_name: 'UsersFollower'
  has_many :followings, through: :users_followings, source: :user

  has_many :pending_followings, -> { UsersFollower.pending }, through: :users_followings, source: :user
  has_many :accepted_followings, -> { UsersFollower.accepted }, through: :users_followings, source: :user
  has_many :denied_followings, -> { UsersFollower.denied }, through: :users_followings, source: :user

  # likes
  has_many :likes, dependent: :destroy
end
