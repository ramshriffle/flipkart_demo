# frozen_string_literal: true

# generate csv file class
class GenerateCsvWorker
  include Sidekiq::Worker

  def perform
    orders = Order.where(created_at: Date.today.all_day)
    if orders.present?
      csv_data =  CSV.generate do |csv|
       csv << ['Order id', 'Customer name', 'Product name', 'Quantity', 'Product Price', 'Total Price']
       orders.each do |order|
         csv << [order.id, order.customer.name, order.product.title, order.quantity, order.product.price, order.price]
       end
      end
      filename = "/home/hp/Desktop/csv/daily_orders_#{Date.today}.csv"
      File.open(filename, 'w') {|file| file.write(csv_data)}
      OrderMailer.with(user: User.find_by_email('ramshriffle@yopmail.com')).send_csv_daily(filename).deliver_now
    end
  end
end
