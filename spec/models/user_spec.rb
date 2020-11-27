require 'rails_helper'

RSpec.describe User, type: :model do
  context "name が空の場合" do  
    it "無効" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end
  end
  
  context "ユーザーが正しく保存される" do
    before do 
      @user = User.new
      @user.name =  "taro"
      @user.email = "test@example.com"
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.save
    end
    it "全てデータが入っているので、保存される" do
      expect(@user).to be_valid
    end
  end
end
