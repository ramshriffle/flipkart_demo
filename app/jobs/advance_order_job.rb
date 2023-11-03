# frozen_string_literal: true

class AdvanceOrderJob < ApplicationJob
  queue_as :default

  def perform(_user)
    # Do something later
    byebug
    order = @current_user.orders.new(order_params)
    if order.save
      # OrderMailer.with(user: @current_user, order: order).order_confirmed.deliver_now
      render json: order, status: 201
    else
      render json: order.errors.full_messages, status: :unprocessable_entity
    end
  end

  def order_params
    params.require(:order).permit(:address_id, order_items_attributes: %i[quantity product_id])
  end
end
