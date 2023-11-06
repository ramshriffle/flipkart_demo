# frozen_string_literal: true

# carts controller
class CartsController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource

  before_action :set_params, only: %i[show destroy]

  def show
    byebug
    render json: @cart, status: :ok
  end

  def destroy
    byebug
    return render json: { message: 'Cart deleted successfully!!' }, status: :ok if @cart.destroy

    render json: @cart.errors.full_messages
  end

  private

  def set_params
    @cart = @current_user.cart
    render json: 'Cart not found', status: :not_found unless @cart
  end
end
