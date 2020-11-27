class Post < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3, maximum: 64}
  validates :body, presence: true, length: {minimum: 3, maximum: 1024}
  belongs_to :user
  has_many :post_votes, dependent: :destroy
end
