class TweetFavoritesController < ApplicationController

  def create
    @tweet = Tweet.find(params[:tweet_id])
    favorite = TweetFavorite.new(tweet_id: params[:tweet_id])
    favorite.user_id = current_user.id
    favorite.save
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.tweet_favorites.find_by(tweet_id: params[:tweet_id])
    favorite.destroy
  end
end
