# frozen_string_literal: true

# user controller
class UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      UserMailer.with(user: user).welcome_email.deliver_now
      render json: user, status: 201
    else
      render json: user.errors.full_messages
    end
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password, :type, :mobile_no)
  end
end
