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

  resources :orders do
    resources :order_items, only: %i[index]
  end
  post 'buy_now', to: 'orders#buy_now'

  resource :carts, only: %i[show destroy]
  resources :cart_items
end
