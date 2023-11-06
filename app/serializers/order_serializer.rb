# frozen_string_literal: true

# order serializer
class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :address_id, :order_items
end
