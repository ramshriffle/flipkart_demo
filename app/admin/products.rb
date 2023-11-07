# frozen_string_literal: true

ActiveAdmin.register Product do
  permit_params :title, :description, :quantity, :price, :rating, :category, :user_id, :image

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :category
    column :quantity
    column :price
    column :rating
    column :vendor

    # column :image do |img|
    #   image_tag img.image.url, size: '30x30'
    # end
    actions
  end

  filter :title
  filter :category
  filter :price
  filter :vendor # , collection: Vendor.all.map{|a| [a.name , a.id] }

  form do |f|
    f.inputs do
      f.input :vendor # , collection: Vendor.all.map{|a| [a.name , a.id] }
      f.input :title
      f.input :description
      f.input :category
      f.input :quantity
      f.input :price
      f.input :rating
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :category
      row :quantity
      row :price
      row :rating

      if resource.image.attached?
        row :image do |img|
          image_tag img.image.url, size: '30x30'
        end
      end
    end
  end
end
