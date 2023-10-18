# frozen_string_literal: true

# product class
class Product < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
end
