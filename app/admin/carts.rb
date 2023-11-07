# frozen_string_literal: true

ActiveAdmin.register Cart do
  permit_params :user_id

  index do
    selectable_column
    id_column
    column :customer
    actions
  end

  filter :customer # , collection: Customer.all.map{|a| [a.name , a.id] }

  form do |f|
    f.inputs do
      f.input :customer # , collection: Customer.all.map{|a| [a.name , a.id] }
    end
    f.actions
  end
end
