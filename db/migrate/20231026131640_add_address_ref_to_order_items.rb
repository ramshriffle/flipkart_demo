class AddAddressRefToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :address, null: false, foreign_key: true, default: 0
  end
end
