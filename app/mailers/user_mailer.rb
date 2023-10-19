# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Registration successful')
  end

  def sent_otp_email(user)
    @user = user
    mail(to: @user.email, subject: 'Otp for login !!')
  end
end
