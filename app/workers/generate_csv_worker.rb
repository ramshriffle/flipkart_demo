# frozen_string_literal: true

# generate csv file class
class GenerateCsvWorker
  include Sidekiq::Worker

  def perform
    orders = Order.where(created_at: Date.today.all_day)

    if orders.present?
      data = CSV.generate do |csv|
        csv << ['Order id', 'Customer name', 'Product name', 'Quantity', 'Total Price']
        orders.each do |order|
          csv << [order.id, order.customer.name, order.product.title, order.quantity, order.price]
        end
      end
      filename = '/home/hp/Desktop/csv/daily_orders.csv'

      File.open(filename, 'w') { |file| file.write(data) }
    end 
  end
end
