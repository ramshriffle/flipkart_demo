class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :city, :pincode, :user_id
end
