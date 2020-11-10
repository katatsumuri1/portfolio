Rails.application.routes.draw do

  devise_for :users
  
  get 'users/quit'
  patch 'users/out'
  resources :users, only: [:show, :edit, :update]
  
  get 'tweets/search'
  resources :tweets, only: [:index, :show, :create, :destroy, :new]

  root to: 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
