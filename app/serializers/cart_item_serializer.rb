# frozen_string_literal: true

# cart item serializer
class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price, :product_id, :cart_id, :product_price

  def product_price
    object.product.price
  end
end
