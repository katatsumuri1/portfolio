Rails.application.routes.draw do
  devise_for :users

  get 'users/quit'
  patch 'users/out'
  resources :users, only: %i[show edit update] do
    resource :relationships, only: %i[create destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers'  => 'relationships#followers', as: 'followers'
  end
  get 'tweets/ranking'
  get 'tweets/search'
  get 'tweets/following_tweets'
  resources :tweets, only: %i[index show create destroy new] do
    resource  :tweet_favorites, only: %i[create destroy]
    resources :tweet_comments, only: %i[create destroy] do
      resource :comment_favorites, only: %i[create destroy]
    end
  end

  root to: 'home#top'
  get 'about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
