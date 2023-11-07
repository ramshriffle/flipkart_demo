# frozen_string_literal: true

ActiveAdmin.register CartItem do
  permit_params :quantity, :cart_id, :product_id

  index do
    selectable_column
    id_column
    column :quantity
    column :price
    column :product
    column :cart_id
    actions
  end

  filter :product
  filter :cart, collection: Cart.all.map { |a| [a.customer.name, a.id] }

  form do |f|
    f.inputs do
      f.input :cart, collection: Cart.all.map { |a| [a.customer.name, a.id] }
      f.input :quantity
      f.input :product
    end
    f.actions
  end
end
