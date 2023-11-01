# frozen_string_literal: true

# carts controller
class CartsController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource
  
  before_action :set_params, only: %i[show destroy]

  def show
    render json: @cart, status: :ok
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
