# frozen_string_literal: true

# authentication controller
class AuthenticationController < ApplicationController
  def login
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      return render json: { message: 'before login activate your account' } unless user.verified == true

      token = jwt_encode(user_id: user.id)
      render json: { message: 'login successfully', token: token }, status: :ok
    else
      render json: { message: 'please check your email or password' }, status: :not_found
    end
  end

  def sent_otp
    user = User.find_by_email(params[:email])
    return render json: 'Email not found, check your email', status: :not_found unless user

    user.generate_otp
    UserMailer.sent_otp_email(user).deliver_now
    render json: 'otp successfully generated for login', status: :ok
  end

  def verify_otp
    user = User.find_by(otp: params[:otp])
    if user.present? && user.valid_otp
      user.user_verified
      render json: 'Authorize user, now you can login your account'
    else
      render json: { error: 'otp is not valid or expired. try again' }, status: :not_found
    end
  end
end
