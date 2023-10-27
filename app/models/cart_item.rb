# frozen_string_literal: true

# cart item class
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 1, only_integer: true}
  
  before_save :total_price

  def total_price
    item_price = product.price * quantity
    self.price = item_price
  end
end
