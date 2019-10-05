# User: Authentication class for standard (non-admin, non-guest) users
class User < ApplicationRecord
  has_secure_password
  has_many :books

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
end
