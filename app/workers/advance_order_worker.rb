# frozen_string_literal: true

# advance order class
class AdvanceOrderWorker
  include Sidekiq::Worker

  def perform(user_id, order_params)
    # Do something later
    byebug
    user = User.find_by_id(user_id)
    order = user.orders.new(order_params)
    if order.save
      OrderMailer.with(user: @current_user, order: order).order_confirmed.deliver_now
    end
  end
end
