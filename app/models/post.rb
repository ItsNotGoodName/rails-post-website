class Post < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3, maximum: 64}
  validates :body, presence: true, length: {minimum: 3, maximum: 1024}
  belongs_to :user
  has_many :votes, as: :voteable, dependent: :destroy
end
