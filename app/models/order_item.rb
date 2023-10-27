# frozen_string_literal: true

# order item class
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :address

  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 1, only_integer: true}

  before_save :total_price

  def total_price
    item_price = product.price * quantity
    self.price = item_price
  end
end
