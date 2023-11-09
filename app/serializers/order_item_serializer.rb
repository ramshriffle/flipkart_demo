# frozen_string_literal: true

# order item serializer
class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price, :product_id, :order_id, :product_price

  def product_price
    object.product.price
  end
end
