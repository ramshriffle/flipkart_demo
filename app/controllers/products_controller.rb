# frozen_string_literal: true

# product controller class
class ProductsController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource
  before_action :set_params, only: %i[show update destroy]

  def index
    products = if @current_user.type == 'Vendor'
                 @current_user.products.page(params[:page])
               else
                 Product.page(params[:page])
               end

    render json: products, status: :ok
  end

  def show
    render json: @product, status: :ok
  end

  def create
    byebug
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
    return render json: { message: 'Account deleted successfully!!', data: @product }, status: :ok if @product.destroy

    render json: @product.errors.full_messages
  end

  def search_products
    products = if params[:category].present?
                 Product.where('category LIKE ?', "%#{params[:category]}%").page(params[:page])
               elsif params[:title].present?
                 Product.where('title LIKE ?', "%#{params[:title]}%").page(params[:page])
               else
                 Product.page(params[:page]).per(2)
               end

    return render json: products, status: :ok if products.present?

    render json: 'Product not found', status: :ok
  end

  private

  def product_params
    params.permit(:title, :description, :category, :rating, :quantity, :price, :image)
  end

  def set_params
    @product = @current_user.products.find_by_id(params[:id])
    render json: 'Product not found', status: :not_found unless @product
  end
end
