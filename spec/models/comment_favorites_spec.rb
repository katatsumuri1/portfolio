require 'rails_helper'
RSpec.describe CommentFavorite, type: :model do
  let!(:user) { create(:user)}
  let!(:tweet) {create(:tweet, user: user)}
  let!(:tweet_comment) {create(:tweet_comment, user: user, tweet: tweet)}
  
  context "データが正しく保存される" do
    before do
      @favorite = CommentFavorite.new
      @favorite.user_id = user.id
      @favorite.tweet_comment_id = tweet_comment.id
      @favorite.save
    end
    it "favoriteは正しく保存される" do
      expect(@favorite).to be_valid
    end
  end
  context "データが削除される" do
  let!(:comment_favorite) {create(:comment_favorite, user: user, tweet_comment: tweet_comment)}
    before do 
      @favorite = user.comment_favorites.first
      @favorite.tweet_comment_id = tweet_comment.id
      @favorite.destroy
    end
    it "favoriteは正しく削除される" do
      expect(@favorite).to be_valid
    end
  end
end