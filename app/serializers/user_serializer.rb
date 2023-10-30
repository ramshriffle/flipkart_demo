# frozen_string_literal: true

# user serializer
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :mobile_no, :type, :profile_picture

  def profile_picture
    object.profile_picture.url
  end
end
