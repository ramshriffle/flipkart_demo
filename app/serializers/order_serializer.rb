# frozen_string_literal: true

# order serializer
class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :status, :address_id, :product_price, :product_title, :quantity, :price

  def product_price
    object.product.price
  end

  def product_title
  	object.product&.title 
  end
end
