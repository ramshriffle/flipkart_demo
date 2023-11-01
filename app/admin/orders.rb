# frozen_string_literal: true

ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :user_id, :address_id

  index do
    selectable_column
    id_column
    column :customer
    column :address_id
    actions
  end

  filter :customer # , collection: Customer.all.map{|a| [a.name , a.id] }
  filter :address, collection: Address.all.map{|a| [a.city , a.id] }

  form do |f|
    f.inputs do
      f.input :customer # , collection: Customer.all.map{|a| [a.name , a.id] }
      f.input :address
    end
    f.actions
  end
end
