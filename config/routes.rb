Rails.application.routes.draw do
  resources :pages
  resources :collections
  resources :orders
  resources :provinces
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products
  put '/updateaddress', to: 'users#updateaddress'
  post '/users/authenticate', to: 'users#authenticate'
  resources :users do
    resources :addresses
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
