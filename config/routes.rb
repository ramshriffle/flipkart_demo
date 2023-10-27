# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount Sidekiq::Web => '/sidekiq'

  resource :users
  resources :addresses
  post 'user/login', to: 'authentication#login'
  post 'user/sent_otp', to: 'authentication#sent_otp'
  post 'user/verify_otp', to: 'authentication#verify_otp'

  resources :products
  resources :orders 
  post 'buy_now', to: 'orders#buy_now'
  
  resources :order_items, only: [:index]
  resource :carts do
    delete 'clear_cart', on: :collection
  end

end
