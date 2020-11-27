require 'rails_helper'
RSpec.describe TweetComment, type: :model do
  
  let!(:user) { create(:user) } 
  let!(:tweet) { create(:tweet, user: user) }
  
  context "データが正しく保存される" do
    before do
      @comment = TweetComment.new
      @comment.comment = "コメントテスト"
      @comment.user_id = user.id
      @comment.tweet_id = tweet.id
      @comment.save
    end
    it "commentが入っているのでデータは保存される" do 
      expect(@comment).to be_valid
    end
  end
  context "データが正しく保存されない" do
    before do
      @comment = TweetComment.new
      @comment.comment = ""
      @comment.user_id = user.id
      @comment.tweet_id = tweet.id
      @comment.save
    end
    it "commentが入力されていないので保存されない" do
      expect(@comment.errors[:comment]).to include("を入力してください")
    end
  end
end
