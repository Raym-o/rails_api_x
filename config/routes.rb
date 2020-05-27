Rails.application.routes.draw do
  resources :pages
  resources :collections
  resources :orders
  resources :products
  resources :provinces
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post '/users/authenticate', to: 'users#authenticate'
  resources :users
  resources :addresses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
