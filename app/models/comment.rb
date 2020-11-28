class Comment < ApplicationRecord
  validates :body, presence: true, length: {minimum: 3, maximum: 1024}
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :voteable, dependent: :destroy

  scope :with_vote_value, ->(user) {
    select("comments.*, votes.value as vote_value")
      .joins("LEFT JOIN votes ON votes.user_id = #{user.nil? && -1 || user.id} AND votes.voteable_id = comments.id AND votes.voteable_type = 'Comment' ")
  }
end
