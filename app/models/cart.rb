# frozen_string_literal: true

# cart class
class Cart < ApplicationRecord
  belongs_to :customer, foreign_key: 'user_id'
  has_many :cart_items, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[cart_items customer]
  end
end
