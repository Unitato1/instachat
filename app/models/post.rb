class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  validates :author, :title, :body, presence: true
  validates :title, length: { minimum: 3, maximum: 20}
  validates :body, length: { minimum: 20, maximum: 300}

  has_many :likes, dependent: :destroy
end
