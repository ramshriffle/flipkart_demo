# frozen_string_literal: true

# orders controller
class OrdersController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource

  before_action :set_params, only: %i[show destroy]

  def index
    orders = @current_user.orders
    return render json: 'you have not order anything' if orders.empty?

    render json: orders.page(params[:page]), status: :ok
  end

  def show
    render json: @order
  end

  def create
    if @current_user.cart.present?
      cart_items = @current_user.cart.cart_items
      return render json: 'Item not found in the cart' if cart_items.empty?

      order = order_now(cart_items)

      if order.save
        # OrderMailer.with(user: @current_user, order: order).order_confirmed.deliver_now
        cart_items.destroy_all
        render json: order.order_items
      else
        render json: order.errors.full_messages
      end
    else
      render json: 'Cart is empty'
    end
  end

  def buy_now
    order = @current_user.orders.new(order_params)
    if order.save
      # OrderMailer.with(user: @current_user, order: order).order_confirmed.deliver_now
      render json: order, status: :created
    else
      render json: order.errors.full_messages, status: :unprocessable_entity
    end
  end

  def order_now(cart_items)
    order = @current_user.orders.new(order_params)
    cart_items.each do |item|
      order.order_items.new(product_id: item.product_id, quantity: item.quantity)
    end
    order
  end

  def destroy
    return render json: 'Order cancel succssefully', status: :ok if @order.destroy

    render json: @order.errors.full_messages, status: :ok
  end

  private

  def order_params
    params.require(:order).permit(:address_id, order_items_attributes: %i[quantity product_id])
  end

  def set_params
    @order = @current_user.orders.find_by_id(params[:id])
    render json: 'order not found', status: :not_found unless @order
  end
end
