# frozen_string_literal: true

# address controller
class AddressesController < ApplicationController
  before_action :authorize_request
  before_action :set_params, only: %i[show destroy]

  def index
    byebug
    addresses = @current_user.addresses.all
    render json: addresses, status: :ok
  end

  def show
    byebug
    render json: @address, status: :ok
  end

  def create
    address = @current_user.addresses.new(address_params)
    if address.save
      render json: address, status: 201
    else
      render json: address.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    return render json: 'Address remove successfully', status: :ok if @address.destroy

    render json: @address.errors.full_messages
  end

  def set_params
    byebug
    @address = @current_user.addresses.find_by_id(params[:id])
    render json: 'Address not found' unless @address # .nil?
  end

  def address_params
    params.permit(:street, :city, :pincode)
  end
end
