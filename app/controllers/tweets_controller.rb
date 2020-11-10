class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
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

  def search
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:body,:image)
  end
end
