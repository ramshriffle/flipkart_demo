# frozen_string_literal: true

# cart serializer
class CartSerializer < ActiveModel::Serializer
  attributes :id, :user_id
end
