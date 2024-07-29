class UsersFollower < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: "User"

  validates :status, presence: true, inclusion: { in: ["pending", "accepted", "denied"]}
  validates :user_id, uniqueness: { scope: :follower_id }

  scope :pending, -> {where(status: "pending")}
  scope :accepted, -> {where(status: "accepted")}
  scope :denied, -> {where(status: "denied")}
end
