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
    byebug
    available_quantity = self.product.quantity - self.sum_product_orders
    if quantity > available_quantity
      errors.add(:base, "Product is not available, Please order only what's available")
    end
  end

  def sum_product_orders
    OrderItem.where(product: self.product).sum(:quantity)
  end

  def total_price
    item_price = product.price * quantity
    self.price = item_price
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "price", "product_id", "quantity", "updated_at"]
  end
end
