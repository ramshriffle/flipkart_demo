# frozen_string_literal: true

# order item class
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :address
end
