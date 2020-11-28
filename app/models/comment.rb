class Comment < ApplicationRecord
  validates :body, presence: true, length: {minimum: 3, maximum: 1024}
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
