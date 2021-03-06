class TweetCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = TweetComment.new(tweet_comment_params)
    @comment.user_id = current_user.id
    @comment.tweet_id = @tweet.id
    @comment.save
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    tweet_comment = TweetComment.find_by(id: params[:id], tweet_id: params[:tweet_id])
    if tweet_comment.user_id = current_user.id
      tweet_comment.destroy
    end
  end

  private

  def tweet_comment_params
    params.require(:tweet_comment).permit(:comment)
  end
end
