# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :address_id, :order_items
end
