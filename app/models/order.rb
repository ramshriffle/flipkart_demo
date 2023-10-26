# frozen_string_literal: true

# order class
class Order < ApplicationRecord
  belongs_to :customer, foreign_key: 'user_id'
  has_many :order_items, dependent: :destroy
end
