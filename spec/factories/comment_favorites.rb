FactoryBot.define do 
  factory :comment_favorite do
    association :tweet_comment
    user {tweet_comment.user}
  end
end