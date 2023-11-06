# frozen_string_literal: true

# order item controller
class OrderItemsController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource

  def index
    order = @current_user.orders.find_by_id(params[:order_id])
    return render json: 'Order not found', status: :not_found unless order

    render json: order.order_items.all, status: :ok
  end
end
