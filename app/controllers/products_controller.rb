# frozen_string_literal: true

# product controller class
class ProductsController < ApplicationController
  before_action :authorize_request#, execpt: %i[test_api]
  load_and_authorize_resource
  before_action :set_params, only: %i[show update destroy]

  def index
    products = @current_user.products.page(params[:page])
    render json: products, status: :ok
  end

  def show
    render json: @product, status: :ok
  end

  def create
    product = @current_user.products.new(product_params)
    if product.save
      render json: product, status: :ok
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
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
    return render json: { message: 'Product delete successfully' }, status: :ok if @product.destroy

    render json: @product.errors.full_messages
  end

  def search_products
    products = if params[:category].present?
                 Product.all.where('category LIKE ?', "%#{params[:category]}%")
               elsif params[:title].present?
                 Product.all.where('title LIKE ?', "%#{params[:title]}%")
               else
                 Product.all
               end
    return render json: products, status: :ok if products.present?

    render json: 'Product not found', status: :not_found
  end

  # def test_api
  #   Product.reindex
  #   products = Product.search(params[:query])
  #   render json: products, status: :ok
  # end

  private

  def product_params
    params.permit(:title, :description, :category, :rating, :quantity, :price, :image)
  end

  def set_params
    @product = @current_user.products.find_by_id(params[:id])
    render json: { errors: 'Product not found' }, status: :not_found unless @product
  end
end
