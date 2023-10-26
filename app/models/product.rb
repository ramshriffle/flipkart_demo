# frozen_string_literal: true

# product class
class Product < ApplicationRecord
  belongs_to :vendor, foreign_key: 'user_id'
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_one_attached :image

  validates :title, :description, :category, :price, presence: true
  validates :quantity, numericality: { only_integer: true, in: 0..100 }
  validates :price, numericality: { greater_than: 0 }
  validates :rating, numericality: { in: 0..5 }
end
