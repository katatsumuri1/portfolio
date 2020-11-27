FactoryBot.define do
  factory :tweet_comment do
      comment{'改善しましょう'}
      
    association :tweet
    user { tweet.user}
  end
end