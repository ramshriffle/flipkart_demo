# frozen_string_literal: true

# create order
class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.decimal :price
      t.references :user, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
