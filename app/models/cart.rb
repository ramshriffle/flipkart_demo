# frozen_string_literal: true

# cart class
class Cart < ApplicationRecord
  belongs_to :customer, foreign_key: 'user_id'
  has_many :cart_items, dependent: :destroy
end
