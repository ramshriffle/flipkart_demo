# frozen_string_literal: true

# orders controller
class OrdersController < ApplicationController
  before_action :set_params, only: [:show, :update, :destroy]

  def index
    orders = @current_user.orders # .includes(:order_items)
    return render json: orders unless orders.empty?

    render json: 'No Orders yet'
  end

  def show
    render json: @order
  end

  def update
    return render json: @order, status: :ok if @order.update(order_params)

    render json: @order.errors.full_messages, status: :ok
  end

  def destroy
    return render json: 'Order cancel succssefully', status: :ok if @order.destroy

    render json: @order.errors.full_messages, status: :ok
  end

  private

  def order_params
    params.permit(:shipping_address)
  end

  def set_params
    @order = @current_user.orders.find_by_id(params[:id])
    render json: 'You did not order anything' if @order.nil?
  end
end
