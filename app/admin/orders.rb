# frozen_string_literal: true

ActiveAdmin.register Order do
  permit_params :user_id, :address_id, :product_id, :status, :quantity

  index do
    selectable_column
    id_column
    column :customer
    column :address_id
    column :status
    column :product_id
    column :quantity
    actions
  end

  filter :customer # , collection: Customer.all.map{|a| [a.name , a.id] }
  filter :address#, collection: User.find_by_id(:user_id).addresses.all.map { |a| [a.city, a.id] }
  # filter :address, collection: Address.all.map { |a| [a.city, a.id] }

  form do |f|
    f.inputs do
      f.input :customer # , collection: Customer.all.map{|a| [a.name , a.id] }
      f.input :address, collection: Address.all.map { |a| [a.city, a.id] }
      f.input :product, collection: Product.all.map { |p| [p.title, p.id] }
      f.input :quantity
    end
    f.actions
  end
end
