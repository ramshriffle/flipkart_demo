# frozen_string_literal: true

# user class
class User < ApplicationRecord
  has_many :addresses, dependent: :destroy

  has_secure_password
  validates :name, :username, :email, :mobile_no, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :mobile_no, length: { is: 10 }

  def generate_otp!
    self.otp = SecureRandom.hex(3)
    self.otp_sent_at = Time.now.utc
    save!
  end

  def valid_otp
    (otp_sent_at + 1.hours) > Time.now.utc
  end

  def user_verified
    self.otp = nil
    self.verified = true
    save
  end
end
