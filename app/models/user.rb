# frozen_string_literal: true

# user class
class User < ApplicationRecord
  validates :name, :username, :email, :mobile_no, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :mobile_no, length: { is: 10 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: :password_digest_changed?

  has_secure_password
  has_one_attached :profile_picture

  has_many :addresses, dependent: :destroy

  def generate_otp
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

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email id mobile_no name otp otp_sent_at password_digest type updated_at
       username verified]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[addresses profile_picture_attachment profile_picture_blob]
  end
end
