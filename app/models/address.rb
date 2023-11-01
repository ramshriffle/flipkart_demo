# frozen_string_literal: true

# address class
class Address < ApplicationRecord
  validates :city, :street, :pincode, presence: true
  validates :pincode, length: { is: 6 }

  belongs_to :user
  has_many :orders, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["city", "created_at", "id", "pincode", "street", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "user"]
  end
end
