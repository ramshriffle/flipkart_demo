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

    order = order_now(cart_items)
    if order.save
      # OrderMailer.with(user: @current_user, order: order).order_confirmed.deliver_now
      cart_items.destroy_all
      render json: order.order_items, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def order_now(cart_items)
    order = @current_user.orders.new(order_params)
    cart_items.each do |item|
      order.order_items.new(product_id: item.product_id, quantity: item.quantity)
    end
    order
  end

  def buy_now
    order = @current_user.orders.new(order_params)
    if order.save
      # OrderMailer.with(user: @current_user, order: order).order_confirmed.deliver_now
      render json: order, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #cancel order
  def update
    if params[:status] == 'cancel'
    return render json: { message: "Order cancel succssefully" }, status: :ok if @order.update(status: params[:status])

    render json: @order.errors.full_messages, status: :unprocessable_entity
    else
      render json: 'wrong input, you can only cancel order'
    end
  end

  private

  def order_params
    params.require(:order).permit(:address_id, :status, order_items_attributes: %i[quantity product_id])
  end

  def set_params
    byebug
    @order = @current_user.orders.find_by_id(params[:id])
    render json: 'order not found', status: :not_found unless @order
  end
end
