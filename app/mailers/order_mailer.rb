class OrderMailer < ApplicationMailer
  def order_confirmed
    @user = params[:user]
    @order = params[:order]
    mail(to: @user.email, subject: 'Order has been confirmed')
  end
end
