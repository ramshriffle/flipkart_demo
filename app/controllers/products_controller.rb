# frozen_string_literal: true

# product controller class
class ProductsController < ApplicationController
  before_action :set_params, only: %i[show update destroy]
  before_action :check_vendor

  def index
    products = Product.all
    render json: products
  end

  def show
    render json: @product, status: :ok
  end

  def create
    product = @current_user.products.new(product_params)
    if product.save
      render json: product, status: :ok
    else
      render json: product.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      render json: 'Product successfully deleted'
    else
      render json: @product.errors.full_messages
    end
  end

  private

  def product_params
    params.permit(:title, :description, :category, :rating, :quantity, :price, :image)
  end

  def set_params
    @product = @current_user.products.find_by_id(params[:id])
    render json: 'Product not found' if @product.nil?
  end
end
