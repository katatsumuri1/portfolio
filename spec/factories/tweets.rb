FactoryBot.define do
  # ユーザーモデルとアソシエーションする
  factory :tweet do 
    body {"ツイート内容テスト"}
    image {""}
    association :owner
    
    #bodyがnil
    trait :nil_body do
      body nil
    end
   
    #bodyの文字が256文字
    trait :character_limit_exceeded do
      body {"a" * 256}
    end
    
    
    
  end
end