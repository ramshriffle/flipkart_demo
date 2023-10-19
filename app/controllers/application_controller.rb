# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  # protect_from_forgery
  include JsonWebToken

  before_action :authorize_request
  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = jwt_decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def check_vendor
    render json: 'You have not permission for this task' unless @current_user.type == 'Vendor'
  end
end
