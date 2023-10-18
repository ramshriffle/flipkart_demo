# frozen_string_literal: true

ActiveRecord::Schema[7.0].define(version: 20_231_018_073_238) do
  create_table 'cart_items', force: :cascade do |t|
    t.decimal 'total_amount'
    t.integer 'qauntity'
    t.integer 'cart_id', null: false
    t.integer 'product_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['cart_id'], name: 'index_cart_items_on_cart_id'
    t.index ['product_id'], name: 'index_cart_items_on_product_id'
  end

  create_table 'carts', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_carts_on_user_id'
  end

  create_table 'order_items', force: :cascade do |t|
    t.integer 'qauntity'
    t.decimal 'price'
    t.integer 'order_id', null: false
    t.integer 'product_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_order_items_on_order_id'
    t.index ['product_id'], name: 'index_order_items_on_product_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.string 'shipping_address'
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_orders_on_user_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.string 'category'
    t.float 'rating'
    t.integer 'quantity'
    t.decimal 'price'
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_products_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'username'
    t.string 'email'
    t.string 'password_digest'
    t.string 'type'
    t.integer 'mobile_no'
    t.string 'confirm_token'
    t.datetime 'confirm_token_sent_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'cart_items', 'carts'
  add_foreign_key 'cart_items', 'products'
  add_foreign_key 'carts', 'users'
  add_foreign_key 'order_items', 'orders'
  add_foreign_key 'order_items', 'products'
  add_foreign_key 'orders', 'users'
  add_foreign_key 'products', 'users'
end
