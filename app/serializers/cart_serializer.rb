# frozen_string_literal: true

class CartSerializer < ActiveModel::Serializer
  attributes :id, :user_id
end
