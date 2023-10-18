# frozen_string_literal: true

# user class
class User < ApplicationRecord
  has_secure_password
  validates :name, :username, :email, :mobile_no, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :mobile_no, length: { is: 10 }
  validates :password,
            length: { minimum: 6 }
end
