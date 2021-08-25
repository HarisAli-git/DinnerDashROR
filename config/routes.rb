Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  devise_for :users, controller: { registrations: 'devise/registrations' }
  get 'home/about'
  root 'home#index'
  resources :items
  resources :cart_items
  resources :categories
  resources :line_items
  resources :checkouts
  resources :carts
  resources :orders
  post 'checkouts/index'
  get 'admins/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
