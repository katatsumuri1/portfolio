class TweetsController < ApplicationController
  
  def index
    @random = Tweet.where.not(user_id: current_user.id).order("RANDOM()").limit(4)
    @q = Tweet.ransack(params[:q])
    @results = @q.result(distinct: true)
    @tweets = Tweet.all.order(created_at: "DESC")
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
    @random = Tweet.where.not(user_id: current_user.id).order("RANDOM()").limit(4)
    @tweets = Tweet.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: "DESC")
    @q = Tweet.ransack(params[:q])
    @results = @q.result(distinct: true)
  end
  
  def search
    @q = Tweet.ransack(params[:q])
    @results = @q.result(distinct: true)
  end

  def ranking
    range = Date.today.in_time_zone.all_month
    @favorites = Tweet.where(created_at: range).find(TweetFavorite.group(:tweet_id).order('count(tweet_id) desc').limit(3).pluck(:tweet_id))
    @comments = TweetComment.where(created_at: range).find(CommentFavorite.group(:tweet_comment_id).order('count(tweet_comment_id) desc').limit(3).pluck(:tweet_comment_id))
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:body,:image)
  end
  
  def search_params
    params.require(:q).permit(:body_cont)
  end
end
