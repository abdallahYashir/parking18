Rails.application.routes.draw do
  resources :configs
  resources :parks
  resources :cars
  root 'businesses#index'
  resources :businesses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
