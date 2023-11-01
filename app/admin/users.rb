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

  permit_params :name, :username, :password, :password_confirmation, :email, :type, :mobile_no, :profile_picture

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
      f.input :profile_picture, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :username
      row :email
      row :type
      row :mobile_no

      if resource.profile_picture.attached?
        row :profile_picture do |img|
          image_tag img.profile_picture.url, size: "40x40"
        end
      else
        row :profile_picture do |img|
          "No profile photo"
        end
      end
    end
  end
end
