class Tweet < ApplicationRecord
  # 投稿を降順に表示する
  belongs_to :user
  attachment :image
  has_many :tweet_comments, dependent: :destroy
  has_many :tweet_favorites, dependent: :destroy
  validates :body, presence:true
  # いいねに自分が含まれているかどうか判断する
  def favorited_by?(user)
    tweet_favorites.where(user_id: user.id).exists?
  end
end
