# frozen_string_literal: true

# api integration class
class ApiIntegrationWorker
  include Sidekiq::Worker

  def perform
    # byebug
    api_products = HTTParty.get('https://fakestoreapi.com/products')
    api_products.each do |item|
      product = Product.find_by(title: item['title'])
      next if product

      Product.create(
        title: item['title'],
        description: item['description'],
        category: item['category'],
        quantity: item['rating']['count'],
        price: item['price'],
        rating: item['rating']['rate'],
        user_id: 3
        # image: item['image']
      )
    end
  end
end
