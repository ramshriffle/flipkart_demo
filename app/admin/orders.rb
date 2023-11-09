# frozen_string_literal: true

ActiveAdmin.register Order do
  permit_params :user_id, :address_id, :status

  index do
    selectable_column
    id_column
    column :customer
    column :address_id
    column :status
    actions
  end

  filter :customer # , collection: Customer.all.map{|a| [a.name , a.id] }
  filter :address, collection: Address.all.map { |a| [a.city, a.id] }

  form do |f|
    f.inputs do
      f.input :customer # , collection: Customer.all.map{|a| [a.name , a.id] }
      f.input :address
    end
    f.actions
  end
end
