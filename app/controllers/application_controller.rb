# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  include JsonWebToken
  skip_before_action :verify_authenticity_token

  rescue_from CanCan::AccessDenied do |_exception|
    render json: 'Access denied', status: :unauthorized
  end

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  private

  def authorize_request
    token = request.headers[:token] || params[:token]
    token = token.split(' ').last if token
    begin
      decoded = jwt_decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
  attr_accessor :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :handle_exception
  def handle_exception
    render json: { message: 'Record not found' }, status: :not_found
  end
end
