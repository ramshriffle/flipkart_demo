# frozen_string_literal: true

# cart item class
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
end
