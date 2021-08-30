# frozen_string_literal: true

Rails.application.routes.draw do
  get "users/index"
  devise_for :users, controller: { registrations: "devise/registrations" }
  get "home/about"
  root "home#index"
  resources :users
  resources :items
  resources :cart_items
  resources :categories
  resources :line_items
  resources :checkouts
  resources :carts
  resources :orders
  patch "/items/:item_id/update_status" => "items#update_status", as: :update_status
  post "checkouts/index"
  get "admins/index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
