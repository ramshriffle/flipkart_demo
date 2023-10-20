# frozen_string_literal: true

# order class
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :shipping_address, presence: true
end
