class Post < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :body, presence: true, length: {minimum: 3, maximum: 1000}
  belongs_to :user
  has_many :votes, as: :voteable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  scope :with_vote_value, ->(user) {
    select("posts.*, votes.value as vote_value")
      .joins("LEFT JOIN votes ON votes.user_id = #{user.nil? && -1 || user.id} AND votes.voteable_id = posts.id AND votes.voteable_type = 'Post' ")
  }
end
