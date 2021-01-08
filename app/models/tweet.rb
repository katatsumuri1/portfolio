class Tweet < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :tweet_comments, dependent: :destroy
  has_many :tweet_favorites, dependent: :destroy
  validates :body, presence: true ,length: {maximum: 255}
  
  #退会済みユーザーを取り除く
  scope :exclude_withdrawn_users, ->{joins(:user).where(users: { is_deleted: false })}
  
  # いいねに自分が含まれているかどうか判断する
  def favorited_by?(user)
    tweet_favorites.where(user_id: user.id).exists?
  end
end
