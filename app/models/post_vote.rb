class PostVote < ApplicationRecord
  validates :upvote null: false
  belongs_to :post
  belongs_to :user
end
