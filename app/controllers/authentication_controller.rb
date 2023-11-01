# frozen_string_literal: true

# authentication controller
class AuthenticationController < ApplicationController
  def login
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      return render json: 'before login activate your account' unless user.verified == true

      token = jwt_encode(user_id: user.id)
      render json: { message: 'login successfully', token: token }
    else
      render json: 'please check your email or password'
    end
  end

  def sent_otp
    user = User.find_by_email(params[:email])
    if user.present?
      user.generate_otp
      UserMailer.sent_otp_email(user).deliver_now
      render json: 'otp successfully generated for login'
    else
      render json: 'Email not found, check your email'
    end
  end

  def verify_otp
    user = User.find_by(otp: params[:otp])
    if user.present? && user.valid_otp
      user.user_verified
      render json: 'Authorize user, now you can login your account'
    else
      render json: {error:  "otp is not valid or expired. try again"}, status: :not_found
    end
  end
end
