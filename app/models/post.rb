class Post < ApplicationRecord
  include Voteable
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :body, presence: true, length: {minimum: 3, maximum: 1000}
  belongs_to :user
  has_many :votes, as: :voteable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
