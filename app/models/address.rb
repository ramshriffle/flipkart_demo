# frozen_string_literal: true

# address class
class Address < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :city, :street, :pincode, presence: true
  validates :pincode, length: { is: 6 }
end
