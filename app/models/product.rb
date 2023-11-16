# frozen_string_literal: true

# product class
class Product < ApplicationRecord
  paginates_per 2
  validates :title, :description, :category, :quantity, :price, :rating, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :rating, numericality: { in: 1..5 }

  has_one_attached :image

  belongs_to :vendor, foreign_key: 'user_id'
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[category created_at description id price quantity rating title updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[cart_items image_attachment image_blob order_items vendor]
  end
end
