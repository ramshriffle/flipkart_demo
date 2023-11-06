# frozen_string_literal: true

class AdvanceOrderWorker
  include Sidekiq::Worker

  def perform(user, order_params)
    # Do something later
    byebug
    order = user.orders.new(order_params)
    if order.save
      OrderMailer.with(user: @current_user, order: order).order_confirmed.deliver_now
      cart_items.destroy_all
      render json: order.order_items
    else
      render json: order.errors.full_messages
    end
  end
end
