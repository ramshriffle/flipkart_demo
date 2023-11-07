# frozen_string_literal: true

# cart item controller
class CartItemsController < ApplicationController
  before_action :authorize_request
  before_action :set_cart, only: %i[create]
  before_action :set_params, only: %i[show update destroy]

  load_and_authorize_resource

  def index
    cart_items = @current_user.cart_items.all
    return render json: { message: 'Cart is empty' }, status: :not_found if cart_items.empty?

    render json: cart_items, status: :ok
  end

  def show
    render json: @cart_item, status: :ok
  end

  def create
    cart_item = @current_user.cart_items.find_by_product_id(params[:product_id])
    if cart_item
      update_quantity(cart_item)
      return render json: cart_item, status: :ok
    end

    add_item = @current_user.cart.cart_items.new(cart_item_params)
    if add_item.save
      render json: { message: 'Item added successfully', item: add_item }, status: :created
    else
      render json: add_item.errors, status: :unprocessable_entity
    end
  end

  def update_quantity(cart_item)
    quantity = cart_item.quantity + params[:quantity].to_i
    cart_item.update(quantity: quantity)
  end

  def update
    if @cart_item.update(cart_item_params)
      render json: { message: 'Item update successfully' }, status: 200
    else
      render json: @cart_item.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    return render json: { message: 'Cart item removed successfully' }, status: :ok if @cart_item.destroy

    render json: @cart_item.errors.full_messages
  end

  def set_params
    @cart_item = @current_user.cart_items.find_by_id(params[:id])
    render json: 'item not found', status: :not_found unless @cart_item
  end

  def set_cart
    @cart = @current_user.create_cart unless @current_user.cart
  end

  private

  def cart_item_params
    params.permit(:product_id, :quantity)
  end
end
