class TweetsController < ApplicationController
  def index
    @q = Tweet.ransack(params[:q])
    @results = @q.result(distinct: true)
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_comment = TweetComment.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
       flash[notice] = "つぶやきを投稿しました"
       redirect_to tweets_path
    else
      render :new
    end
  end

  def new
    @Tweet = Tweet.new
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end
  
  def following_tweets
    @tweets = Tweet.where(user_id: [current_user.id, *current_user.following_ids])
    @q = Tweet.ransack(params[:q])
    @results = @q.result(distinct: true)
  end
  
  def search
    @q = Tweet.ransack(params[:q])
    @results = @q.result(distinct: true)
  end
  
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:body,:image)
  end
  
  def search_params
    params.require(:q).permit(:body_cont)
  end
end
