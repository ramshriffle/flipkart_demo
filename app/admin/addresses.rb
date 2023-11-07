# frozen_string_literal: true

ActiveAdmin.register Address do
  permit_params :street, :city, :pincode, :user_id

  index do
    selectable_column
    id_column
    column :street
    column :city
    column :pincode
    column :user
    actions
  end

  filter :city
  filter :user

  show do
    attributes_table do
      row :street
      row :city
      row :pincode
      row :user
    end
  end
end
