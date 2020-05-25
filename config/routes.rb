Rails.application.routes.draw do
  post '/users/authenticate', to: 'users#authenticate'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
