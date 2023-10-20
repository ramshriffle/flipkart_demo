class CartsController < ApplicationController
  
  def create
    cart = @current_user.cart
    cart = @current_user.create_cart unless cart.present?

    cart_item = cart.cart_item.create(cart_item_params)
    if cart_item.save
      render json: cart_item, status: :ok
    else
      render json: cart_item.errors.full_messages
    end
  end

  private

  def cart_item_params
    params.require(:cart).permit(cart_items: [:qauntity, :total_amount, :product_id])
  end

  def set_params
    @cart = @current_user.cart.find_by_id(params[:id])
    render json: 'Cart not found' if @cart.nil?
  end
end
