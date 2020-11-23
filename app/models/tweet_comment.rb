class TweetComment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_many :comment_favorites, dependent: :destroy
  validates :comment, presence: true
  def comment_favorited_by?(user)
    comment_favorites.where(user_id: user.id).exists?
  end
end
