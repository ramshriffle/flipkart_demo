# frozen_string_literal: true

# orders controller
class OrdersController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource
  before_action :set_params, only: %i[show cancel_order]

  def index
    orders = @current_user.orders
    render json: orders.page(params[:page]), status: :ok
  end

  def show
    render json: @order
  end

  def create
    cart_items = @current_user.cart_items.all
    return render json: 'Cart is empty', status: :no_content if cart_items.empty?

    order_now(cart_items)
  end

  def order_now(cart_items)
    cart_items.each do |item|
      order = @current_user.orders.new(product_id: item.product_id, quantity: item.quantity,
                                       address_id: params[:address_id])
      return render json: { errors: order.errors.full_messages }, status: :unprocessable_entity unless order.save

      OrderMailer.with(user: @current_user, order: order).order_confirmed.deliver_now
      item.destroy
    end
    render json: 'Order successfully', status: :created
  end

  def buy_now
    order = @current_user.orders.new(order_params)
    if order.save
      OrderMailer.with(user: @current_user, order: order).order_confirmed.deliver_now
      render json: order, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # cancel order
  def update
    if params[:status] == 'cancel'
      if @order.update(status: params[:status])
        return render json: { message: 'Order cancel succssefully' },
                      status: :ok
      end

      render json: @order.errors.full_messages, status: :unprocessable_entity
    else
      render json: 'wrong input, you can only cancel order'
    end
  end

  def test_api
    Order.reindex
    orders = Order.search(params[:query])
    render json: orders,  status: :ok
  end

  private

  def order_params
    params.permit(:address_id, :status, :quantity, :product_id)
  end

  def set_params
    @order = @current_user.orders.find_by_id(params[:id])
    render json: 'order not found', status: :not_found unless @order
  end
end
