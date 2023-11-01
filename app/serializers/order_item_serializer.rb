class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price, :product_id, :order_id
end
