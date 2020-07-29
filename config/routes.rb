Rails.application.routes.draw do
  root to: 'users#index'
  resources :posts, only: :show
  resources :items, only: [:create, :destroy]
  resources :users, only: :index
end
