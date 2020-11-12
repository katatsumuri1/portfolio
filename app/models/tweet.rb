class Tweet < ApplicationRecord
  # 投稿を降順に表示する
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  attachment :image
  has_many :tweet_comments, dependent: :destroy
end
