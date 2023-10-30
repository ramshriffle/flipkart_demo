# frozen_string_literal: true

ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :username, :email, :password_digest, :type, :mobile_no, :otp, :otp_sent_at, :verified
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :username, :email, :password_digest, :type, :mobile_no, :otp, :otp_sent_at, :verified]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :name, :username, :password, :password_confirmation, :email, :type, :mobile_no

  index do
    selectable_column
    id_column
    column :name
    column :username
    column :email
    column :password_digest
    column :type
    column :mobile_no
    actions
  end

  filter :name
  filter :username
  filter :email
  filter :type

  form do |f|
    f.inputs do
      f.input :name
      f.input :username
      f.input :email
      f.input :type
      f.input :mobile_no
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
