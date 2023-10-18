# frozen_string_literal: true

# order item class
class Customer < User
  has_many :orders, foreign_key: 'user_id', dependent: :destroy
  has_many :order_items, through: :orders, foreign_key: 'user_id', dependent: :destroy
  has_one :cart, foreign_key: 'user_id', dependent: :destroy
  has_many :cart_items, through: :cart, foreign_key: 'user_id', dependent: :destroy
end
