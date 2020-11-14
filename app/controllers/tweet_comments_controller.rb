class TweetCommentsController < ApplicationController
  
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = TweetComment.new(tweet_comment_params)
    @comment.user_id = current_user.id
    @comment.tweet_id = @tweet.id
    @comment.save
    
  end
  
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    TweetComment.find_by(id: params[:id],tweet_id: params[:tweet_id]).destroy
  end
  private
  def tweet_comment_params
    params.require(:tweet_comment).permit(:comment)
  end
end
