# frozen_string_literal: true

# orders controller
class OrdersController < ApplicationController
  before_action :set_params, only: %i[show destroy]

  def show
    render json: @order
  end

  def create
    if @current_user.cart.present?
      cart_items = @current_user.cart.cart_items
      return render 'Item not found in the cart' if cart_items.empty?

      order = order_now(cart_items)

      cart_items.destroy_all
      render json: order.order_items
    else
      render json: 'Cart is empty'
    end
  end

  def destroy
    return render json: 'Order cancel succssefully', status: :ok if @order.destroy

    render json: @order.errors.full_messages, status: :ok
  end

  private

  def set_params
    @order = @current_user.orders.find_by_id(params[:id])
    render json: 'You did not order anything' if @order.nil?
  end

  def order_now(cart_items)
    order = @current_user.orders.create
    cart_items.each do |item|
      order.order_items.create(product_id: item.product_id, quantity: item.quantity, address_id: params[:address_id])
    end
    order
  end
end
