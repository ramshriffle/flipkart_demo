# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    order = @current_user.orders.new(order_params)
    if order.save
      render json: order, status: :ok
    else
      render json: order.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.permit(:shipping_address)
  end
end
