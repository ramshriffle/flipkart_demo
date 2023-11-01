# frozen_string_literal: true

ActiveAdmin.register CartItem do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :quantity, :price, :cart_id, :product_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:quantity, :price, :cart_id, :product_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

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
