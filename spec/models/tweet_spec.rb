require 'rails_helper'
RSpec.describe Tweet, type: :model do
    
  let!(:user) { create(:user) }  
  
  context "データが正しく保存される" do
    before do
      @tweet = Tweet.new
      @tweet.body = "失敗内容"
      @tweet.image = ""
      @tweet.user_id = user.id
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
      @tweet.image= nil
      @tweet.user_id = user.id
      @tweet.save
    end
    it "bodyが入力されていないので保存されない" do
      expect(@tweet.errors[:body]).to include("を入力してください")
    end
  end
end