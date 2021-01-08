class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @random = Tweet.joins(:user).where.not(user_id: current_user.id, users: { is_deleted: true }).order('RANDOM()').limit(4)
    @q = Tweet.exclude_withdrawn_users.ransack(params[:q])
    @results = @q.result(distinct: true)
    @tweets = Tweet.exclude_withdrawn_users.order(created_at: 'DESC')
  end

  def show
    @tweet = Tweet.exclude_withdrawn_users.find(params[:id])
    @tweet_comment = TweetComment.new
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    #GoogleNaturalAPIで構文分析したものから名詞のみ取ってくる
    nouns = Language.get_data(tweet_params[:body])
    @tweet.noun = ""
    nouns.each do|noun|
      if noun["partOfSpeech"]["tag"] == "NOUN"
        @tweet.noun += " #{noun["text"]["content"]}"
      end
    end
    
    if @tweet.save
      flash[:notice] = 'つぶやきを投稿しました'
      redirect_to noun_search_tweet_path(@tweet.id)
    else
      render :new
    end
  end

  def new
    @tweet = Tweet.new
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.destroy
      redirect_to tweets_path
    end
  end

  def following_tweets
    @random = Tweet.joins(:user).where.not(user_id: current_user.id, users: { is_deleted: true }).order('RANDOM()').limit(4)
    @tweets = Tweet.exclude_withdrawn_users.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: 'DESC')
    @q = Tweet.exclude_withdrawn_users.ransack(params[:q])
    @results = @q.result(distinct: true)
  end
  
  #ツイートした名詞と一致する過去の投稿を表示する
  def noun_search
    @tweet = Tweet.exclude_withdrawn_users.find(params[:id])
    @tweets = Tweet.joins(:user).where.not(user_id: current_user.id,users: { is_deleted: true }).where("noun LIKE?","%#{@tweet.noun}%")
  end
  
  def search
    @q = Tweet.ransack(params[:q])
    @results = @q.result(distinct: true)
  end

  def ranking
    range = Time.zone.today.in_time_zone.all_month  #今月のデータを取得する
    @favorites = Tweet.joins(:user).joins(tweet_favorites: :user).where("users.is_deleted = ?", false).where("users_tweet_favorites.is_deleted = ?", false)
    .group("tweet_favorites.tweet_id").order("count(tweet_id) desc").where(created_at: range).limit(3)
    
    @comments = TweetComment.joins(:user).joins(comment_favorites: :user).where("users.is_deleted = ?", false).where("users_comment_favorites.is_deleted = ?", false)
    .group("comment_favorites.tweet_comment_id").order("count(tweet_comment_id) desc").where(created_at: range).limit(3)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :image)
  end

  def search_params
    params.require(:q).permit(:body_cont)
  end
end
