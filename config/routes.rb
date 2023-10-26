# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resource :users
  resources :addresses
  post 'user/login', to: 'authentication#login'
  post 'user/sent_otp', to: 'authentication#sent_otp'
  post 'user/verify_otp', to: 'authentication#verify_otp'

  resources :products
  resources :orders
  resource :carts
end
