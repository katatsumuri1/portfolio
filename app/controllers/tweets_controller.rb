class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @random = Tweet.joins(:user).where.not(user_id: current_user.id, users: { is_deleted: true }).order('RAND()').limit(4)
    @q = Tweet.joins(:user).where(users: { is_deleted: false }).ransack(params[:q])
    @results = @q.result(distinct: true)
    @tweets = Tweet.joins(:user).where(users: { is_deleted: false }).order(created_at: 'DESC')
  end

  def show
    @tweet = Tweet.joins(:user).where(users: { is_deleted: false }).find(params[:id])
    @tweet_comment = TweetComment.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      flash[:notice] = 'つぶやきを投稿しました'
      redirect_to tweets_path
    else
      render :new
    end
  end

  def new
    @tweet = Tweet.new
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end

  def following_tweets
    @random = Tweet.joins(:user).where.not(user_id: current_user.id, users: { is_deleted: true }).order('RAND()').limit(4)
    @tweets = Tweet.joins(:user).where(users: { is_deleted: false }).where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: 'DESC')
    @q = Tweet.joins(:user).where(users: { is_deleted: false }).ransack(params[:q])
    @results = @q.result(distinct: true)
  end

  def search
    @q = Tweet.ransack(params[:q])
    @results = @q.result(distinct: true)
  end

  def ranking
    range = Time.zone.today.in_time_zone.all_month
    @favorites = Tweet.joins(:user).where(users: { is_deleted: false }).where(created_at: range)
                            .find(TweetFavorite.joins(:user).where(users: { is_deleted: false }).where(created_at: range).group(:tweet_id).order('count(tweet_id) desc').limit(3).pluck(:tweet_id))
    @comments = TweetComment.joins(:user).where(users: { is_deleted: false }).where(created_at: range)
                            .find(CommentFavorite.joins(:user).where(users: { is_deleted: false }).where(created_at: range).group(:tweet_comment_id).order('count(tweet_comment_id) desc').limit(3).pluck(:tweet_comment_id))
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :image)
  end

  def search_params
    params.require(:q).permit(:body_cont)
  end
end
