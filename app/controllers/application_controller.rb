# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  include JsonWebToken

  attr_accessor :current_user

  skip_before_action :verify_authenticity_token

  rescue_from CanCan::AccessDenied do |_exception|
    render json: 'Access denied', status: :unauthorized
  end

  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = jwt_decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
