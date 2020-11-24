class User < ApplicationRecord
  before_save { self.name = name.downcase }
  validates :name, presence: true, uniqueness: true, length: { maximum: 32 }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  has_many :posts
  has_many :post_votes
end
