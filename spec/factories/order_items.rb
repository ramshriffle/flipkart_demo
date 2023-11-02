FactoryBot.define do
  factory :order_item do
    quantity { 10 }
    price { 50 }
    product
    order
  end
end
