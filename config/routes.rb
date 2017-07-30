Rails.application.routes.draw do
  root to: 'courses#index'
  resources :categories, only: [:show]
  resources :courses, only: %i[index show]
  resources :users, only: %i[new create]
  resources :sessions, only: %i[new create]

  post '/carts', to: 'carts#create'
  get '/cart', to: 'carts#show'
  delete '/cart', to: 'carts#destroy'
  post '/cart', to: 'carts#update'
  get '/dashboard', to: 'users#show'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'
  get ':category_id', to: 'categories#show'
end
