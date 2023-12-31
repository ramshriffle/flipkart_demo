# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  begin
    ActiveAdmin.routes(self)
  rescue StandardError
    ActiveAdmin::DatabaseHitDuringLoad
  end

  mount Sidekiq::Web => '/sidekiq'

  resource :users
  resources :addresses
  post 'user/login', to: 'authentication#login'
  post 'user/sent_otp', to: 'authentication#sent_otp'
  post 'user/verify_otp', to: 'authentication#verify_otp'

  resources :products
  get 'search_products', to: 'products#search_products'
  # get 'test_api', to: 'products#test_api'

  resources :orders
  post 'buy_now', to: 'orders#buy_now'
  get 'test_api', to: 'orders#test_api'
  # put 'cancel_order/:id', to: 'orders#cancel_order'


  resource :carts, only: %i[show destroy]
  resources :cart_items
end
