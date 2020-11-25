FactoryBot.define do
  # ユーザーモデルとアソシエーションする
  factory :tweet do 
    body {'ツイート内容テスト'}
    
    association :user
  end
end