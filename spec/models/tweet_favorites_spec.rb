require 'rails_helper'
RSpec.describe TweetFavorite, type: :model do
  
  let!(:user)  { create(:user)}
  let!(:tweet) { create(:tweet, user: user)}
  
  context "データが正しく保存される" do
    before do
      @favorite = TweetFavorite.new
      @favorite.tweet_id = tweet.id
      @favorite.user_id = user.id
      @favorite.save
    end
    it "favoriteは正しく保存される" do
      expect(@favorite).to be_valid
    end
  end
end

  