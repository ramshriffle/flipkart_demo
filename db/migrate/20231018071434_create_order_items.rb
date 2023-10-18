# frozen_string_literal: true

# create order items
class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :qauntity
      t.decimal :price
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
