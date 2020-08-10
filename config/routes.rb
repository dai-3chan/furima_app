Rails.application.routes.draw do
  root to: 'items#show'
  resources :items
end
