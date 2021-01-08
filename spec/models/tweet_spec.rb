require 'rails_helper'
RSpec.describe Tweet, type: :model do

  describe "ツイートバリデーションテスト" do
    it "イメージは入っていないがデータは保存される" do
      tweet = FactoryBot.create(:tweet)
      expect(tweet).to be_valid
    end
    
    it "bodyが入力されていないので保存されない" do
      tweet = FactoryBot.create(:tweet, :nil_body)
      expect(tweet.errors[:body]).to include("を入力してください")
    end  
  end
    
  describe "bodyの文字数テスト" do
    it "bodyが２５５文字以下なので保存される" do
      tweet = FactoryBot.create(:tweet)
      expect(@tweet).to be_valid
    end
    it "bodyが256文字以上なので保存されない" do
      tweet = FactoryBot.create(:tweet, :character_limit_exceeded)
      expect(@tweet.errors[:body]).to include("以内で入力してください")
    end
  end  
end