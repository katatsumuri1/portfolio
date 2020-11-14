Rails.application.routes.draw do

  devise_for :users
  
  get 'users/quit'
  patch 'users/out'
  resources :users, only: [:show, :edit, :update]
  
  get 'tweets/search'
  #comments,favoritesをネストさせる
  resources :tweets, only: [:index, :show, :create, :destroy, :new] do
    resources :tweet_comments, only: [:create, :destroy]
    resource  :tweet_favorites, only: [:create, :destroy]
  end

  root to: 'home#top'
  get 'about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
