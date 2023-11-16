# frozen_string_literal: true

# user serializer
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :type, :profile_picture # , :addresses

  def profile_picture
    object.profile_picture.url
  end
end
