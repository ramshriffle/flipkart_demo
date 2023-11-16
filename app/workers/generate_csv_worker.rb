# frozen_string_literal: true

# advance order class
class GenerateCsvWorker
    include Sidekiq::Worker
  
    def perform 
      order = Order.where(created_at: Date.today.all_day)

      if order.present?
    end
  end
  