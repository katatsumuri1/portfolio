class TweetComment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  validates :comment, presence: true
  has_many :comment_favorites, dependent: :destroy
  
  def comment_favorited_by?(user)
    comment_favorites.where(user_id: user.id).exists?
  end
end
