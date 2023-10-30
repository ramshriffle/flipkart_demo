# frozen_string_literal: true

# order item controller
class OrderItemsController < ApplicationController
  before_action :authorize_request

  def index
    order = @current_user.orders.find_by_id(params[:id])
    return render json: 'Order not found', status: :not_found unless order

    render json: order.order_items.page(params[:page]), status: :ok
  end
end
