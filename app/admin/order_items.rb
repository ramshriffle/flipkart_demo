# frozen_string_literal: true

ActiveAdmin.register OrderItem do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :quantity, :price, :order_id, :product_id, :address_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:quantity, :price, :order_id, :product_id, :address_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :quantity, :order_id, :product_id
  index do
    selectable_column
    id_column
    column :quantity
    column :price
    column :product
    column :order
    # column :address
    actions
  end

  filter :product
  # filter :address, collection: Address.all.map{|a| [a.city , a.id] }
  filter :order_id # , collection: Order.all.map{|a| [a.customer.name , a.id] }

  form do |f|
    f.inputs do
      f.input :order_id # , collection: Order.all.map{|a| [a.customer.name , a.id] }
      f.input :quantity
      f.input :product_id
    end
    f.actions
  end

  show do
    attributes_table do
      row :quantity
      row :price
      row :product
      row :order
      # row :address
    end
  end
end
