require 'rails_helper'
belongs_to :user
RSpec.describe Tweet, type: :model do
 context "データが正しく保存されるか"
  before do
    @tweet = Tweet.new
    @tweet.body = "テスト投稿"
    @tweet.image =""
    @tweet.save
  end
  it "イメージはNILLで大丈夫なので保存される" do
     expect(@tweet).to be_valid
   end
   
   private
  
end
