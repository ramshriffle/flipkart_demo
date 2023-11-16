# frozen_string_literal: true

# order class
class Order < ApplicationRecord
  paginates_per 2

  enum status: { confirm: 'confirm', cancel: 'cancel' }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }

  belongs_to :customer, foreign_key: 'user_id'
  belongs_to :product
  belongs_to :address

  before_save :total_price

  validate :quantity_is_available

  def quantity_is_available
    available_quantity = product.quantity - sum_product_orders
    return unless quantity > available_quantity

    errors.add(:base, 'Product is not available in more quantity')
  end

  def sum_product_orders
    Order.where(product: product).sum(:quantity)
  end

  def total_price
    item_price = product.price * quantity
    self.price = item_price
  end
end
