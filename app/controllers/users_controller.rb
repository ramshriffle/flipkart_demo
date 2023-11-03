# frozen_string_literal: true

# user controller
class UsersController < ApplicationController
  before_action :authorize_request, except: [:create]

  def show
    render json: @current_user, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      UserMailer.with(user: user).welcome_email.deliver_now
      render json: user, status: 201
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user, status: :ok
    else
      render json: {errors: @current_user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.destroy
    render json: {message: "Account deleted successfully!!"}, status: :ok
  rescue Exception => e
    render json: e.message, status: :internal_server_error
  end

  private

  def user_params
    # params.permit(:name, :username, :email, :password, :password_confirmation, :type, :mobile_no, :profile_picture)
    params.require(:user).permit(
      :name,
      :username,
      :email,
      :password,
      :password_confirmation,
      :type,
      :mobile_no,
      addresses_attributes: %i[
        id
        street
        city
        pincode
      ]
    )
  end
end
