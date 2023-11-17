# frozen_string_literal: true

# class order mailer
class OrderMailer < ApplicationMailer
  def order_confirmed
    @user = params[:user]
    @order = params[:order]
    mail(to: @user.email, subject: 'Order has been confirmed')
  end

  def send_csv_daily(filename)
    @user = params[:user]
    attachments[filename] = File.read(filename)
    mail(to: @user.email, subject: 'Daily Order Details')
  end
end
