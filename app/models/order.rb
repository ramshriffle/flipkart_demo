# frozen_string_literal: true

# order class
class Order < ApplicationRecord
  paginates_per 2
  belongs_to :customer, foreign_key: 'user_id'
  belongs_to :address
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id updated_at user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    ["address", "customer", "order_items"]
  end
end
