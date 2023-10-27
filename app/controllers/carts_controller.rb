# frozen_string_literal: true

# carts controller
class CartsController < ApplicationController
  before_action :set_cart
  before_action :set_params, only: %i[update destroy]

  def show
    @cart_items = @current_user.cart.cart_items
    return render json: 'Items not added to the cart' if @cart_items.empty?

    cart_items_data = @cart_items.map do |cart_item|
      {
        id: cart_item.id, product: cart_item.product.category,
        product_id: cart_item.product_id,
        price: cart_item.price,
        quantity: cart_item.quantity
      }
    end
    render json: cart_items_data
  end

  def create
    cart_item = @current_user.cart_items.find_by_product_id(params[:product_id])
    if cart_item
      update_quantity(cart_item)
      return render json: cart_item, status: :ok
    end

    add_cart = @current_user.cart.cart_items.new(cart_item_params)
    if add_cart.save
      render json: { message: 'Item added successfully', item: add_cart }, status: 200
    else
      render json: add_cart.errors, status: :unprocessable_entity
    end
  end

  def update_quantity(cart_item)
    quantity = cart_item.quantity + params[:quantity]
    cart_item.update(quantity: quantity)
  end

  def update
    if @cart_item.update(cart_item_params)
      render json: 'Item update successfully', status: :ok
    else
      render json: @cart_item.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    render json: 'Cart item removed successfully', status: :ok if @cart_item.destroy
  end

  def set_params
    @cart_item = @current_user.cart.cart_items.find_by_id(params[:id])
    render json: 'item not found' if @cart_item.nil?
  end

  def set_cart
    @cart = @current_user.create_cart unless @current_user.cart.present?
  end

  def clear_cart
    cart = @current_user.cart.cart_items
     unless cart.empty?
      cart.destroy_all
      return render json: "cart items removed successfully"
     end
    render json: "Cart is empty"
  end

  private

  def cart_item_params
    params.permit(:product_id, :quantity)
  end
end
