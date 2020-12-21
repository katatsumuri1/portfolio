class CommentFavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = TweetComment.find(params[:tweet_comment_id])
    @favorite = CommentFavorite.new(tweet_comment_id: params[:tweet_comment_id])
    @favorite.user_id = current_user.id
    @favorite.save
  end

  def destroy
    @comment = TweetComment.find(params[:tweet_comment_id])
    @favorite = current_user.comment_favorites.find_by(tweet_comment_id: params[:tweet_comment_id])
    if @favorite.user_id = current_user.id
      @favorite.destroy
    end
  end
end
