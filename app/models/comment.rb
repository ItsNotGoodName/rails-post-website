class Comment < ApplicationRecord
  include Voteable
  validates :body, presence: true, length: {minimum: 3, maximum: 1024}
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :voteable, dependent: :destroy
end
