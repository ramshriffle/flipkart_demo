# frozen_string_literal: true

ActiveAdmin.register Address do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :street, :city, :pincode, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:street, :city, :pincode, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
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
