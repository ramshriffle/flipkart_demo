# frozen_string_literal: true

# carts controller
class CartsController < ApplicationController
  before_action :authorize_request
  before_action :set_params, only: %i[show destroy]

  def show
    render json: @cart, status: :ok
  end

  def create
    cart = @current_user.create_cart
    if cart.save
      render json: cart, status: :created_at
    else
      render json: cart.errors.full_messages
    end
  end

  def destroy
    return render json: { message: 'Account deleted successfully!!', data: @cart }, status: :ok if @cart.destroy

    render json: @cart.errors.full_messages
  end

  private

  def set_params
    @cart = @current_user.cart
    render json: 'Cart not found', status: :not_found unless @cart
  end
end
