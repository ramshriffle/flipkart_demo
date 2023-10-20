# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category, :quantity, :price, :rating, :user_id, :image

  def image
    object.image.url
  end
end
