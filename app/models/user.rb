VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

class User < ApplicationRecord
  require "securerandom"
  before_save { self.email = email.downcase }
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimun: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end
