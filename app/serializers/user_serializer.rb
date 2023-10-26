# frozen_string_literal: true

# user serializer
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :mobile_no, :type
end
