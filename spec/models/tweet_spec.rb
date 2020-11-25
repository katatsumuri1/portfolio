require 'rails_helper'
RSpec.describe Tweet, type: :model do
  
  
  let!(:user) { create(:user) }  

  
  context "データが正しく保存される" do
    before do
      @tweet = Tweet.new
      @tweet.body = "ツイート内容テスト"
      @tweet.image = "123456e"
      @tweet.user_id = user.id
      @tweet.save
    end
    it "全てデータが入っているので、保存される" do
      expect(@tweet).to be_valid
    end
  end
  context "データが正しく保存される" do
    before do
      @tweet = Tweet.new
      @tweet.body = "失敗内容"
      @tweet.image = ""
      @tweet.save
    end
    it "イメージは入っていないがデータは保存される" do
      expect(@tweet).to be_valid
    end
  end
  context "データが正しく保存されない" do
    before do
      @tweet = Tweet.new
      @tweet.body = ""
      @tweet.image= ""
      @tweet.user_id = current_user.id
      @tweet.save
    end
    it "bodyが入力されていないので保存されない" do
      expect(@tweet).to be_invalid
      expect(@tweet.errors[:body]).to include("が入力されていません")
    end
  end
end