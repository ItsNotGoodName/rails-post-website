class User < ApplicationRecord
  before_save { self.name = name.downcase }
  validates_uniqueness_of :name
  validates_presence_of :name
  has_secure_password
  validates_presence_of :password
end
