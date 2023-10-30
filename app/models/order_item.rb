# frozen_string_literal: true

# order item class
class OrderItem < ApplicationRecord
  paginates_per 1
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }

  belongs_to :order
  belongs_to :product
  belongs_to :address

  before_save :total_price

  def total_price
    item_price = product.price * quantity
    self.price = item_price
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[address_id created_at id order_id price product_id quantity updated_at]
  end
end
