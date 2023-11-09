class AddColumnStatusToOrder < ActiveRecord::Migration[7.0]
  def up
    add_column :orders, :status, :string, default: 'confirm'
  end

  def down
    remove_column :orders, :status, :string
  end
end
