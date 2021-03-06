Rails.application.routes.draw do
  resources :users, only: [:index, :create]
  resources :weapons, only: [:index, :create, :destroy, :show]
  resources :enemies, only: [:index, :show, :create, :update, :destroy]
end
