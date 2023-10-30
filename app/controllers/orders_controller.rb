# frozen_string_literal: true

# orders controller
class OrdersController < ApplicationController
  before_action :authorize_request
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
    order = @current_user.orders.new
    order_item = order.order_items.new(order_item_params)
    return render json: order_item, status: 201 if order_item.save

    render json: order_item.errors.full_messages, status: :unprocessable_entity
  end

  def destroy
    return render json: 'Order cancel succssefully', status: :ok if @order.destroy

    render json: @order.errors.full_messages, status: :ok
  end

  def order_now(cart_items)
    order = @current_user.orders.new
    cart_items.each do |item|
      order.order_items.new(product_id: item.product_id, quantity: item.quantity, address_id: params[:address_id])
    end
    order
  end

  private

  def order_item_params
    params.permit(:product_id, :quantity, :address_id)
  end

  def set_params
    @order = @current_user.orders.find_by_id(params[:id])
    render json: 'order not found' unless @order
  end
end
