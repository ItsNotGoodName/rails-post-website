class User < ApplicationRecord
  before_save { self.username = username.downcase }
  validates :username, presence: true, uniqueness: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6, maximum: 30}
  has_secure_password
  has_many :posts
  has_many :comments
  has_many :votes

  has_many :comments, as: :commentable, dependent: :destroy
end
