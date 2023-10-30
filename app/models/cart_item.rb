# frozen_string_literal: true

# cart item class
class CartItem < ApplicationRecord
  paginates_per 1
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  # validates :user_id, uniqueness: true
  belongs_to :cart
  belongs_to :product

  before_save :total_price

  def total_price
    item_price = product.price * quantity
    self.price = item_price
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[cart_id created_at id price product_id quantity updated_at]
  end
end
