# frozen_string_literal: true

# order item class
class OrderItem < ApplicationRecord
  paginates_per 2
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }

  belongs_to :order
  belongs_to :product

  before_save :total_price

  validate :quantity_is_available

  def quantity_is_available
    available_quantity = product.quantity - sum_product_orders
    return unless quantity > available_quantity

    errors.add(:base, "Product is not available in more quantity")
  end

  def sum_product_orders
    OrderItem.where(product: product).sum(:quantity)
  end

  def total_price
    item_price = product.price * quantity
    self.price = item_price
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id order_id price product_id quantity updated_at]
  end
end
