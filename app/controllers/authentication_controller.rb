# frozen_string_literal: true

# authentication controller
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request

  def login
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      byebug
      token = jwt_encode(user_id: user.id)
      render json: { message: 'login successfully', token: token }
    else
      render json 'please check your email or password'
    end
  end
end
