Rails.application.routes.draw do

  devise_for :users
  
  get 'users/quit'
  patch 'users/out'
  resources :users, only: [:show, :edit, :update]do
    
  end  
  get 'tweets/search'
  resources :tweets, only: [:index, :show, :create, :destroy, :new] do
    resource  :tweet_favorites, only: [:create, :destroy]
    resources :tweet_comments, only: [:create, :destroy] do
    resource  :comment_favorites, only: [:create, :destroy]
  end
  end
  
 

  root to: 'home#top'
  get 'about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
