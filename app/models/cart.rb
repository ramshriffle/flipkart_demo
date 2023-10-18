# frozen_string_literal: true

# cart class
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
end
