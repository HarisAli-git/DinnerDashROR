Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  devise_for :users
  get 'home/about'
  root 'home#index'
  get 'items/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
