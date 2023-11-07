# frozen_string_literal: true

# api integration class
class ApiIntegration
  include Sidekiq::Worker

  def perform
    # Do something later
    HTTParty.get('https://fakestoreapi.com/products')
  end
end
