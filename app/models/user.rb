class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  validates :name, presence: true

  has_many :tweets, dependent: :destroy
  has_many :tweet_comments, dependent: :destroy
  has_many :tweet_favorites, dependent: :destroy
  has_many :comment_favorites, dependent: :destroy
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: :relationship
  # 自分がフォローしている人を取ってくる
  has_many :followings, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy, inverse_of: :relationship
  # 自分をフォローしている人を取ってくる
  has_many :followers, through: :reverse_of_relationships, source: :follower

  enum is_deleted: { Availble: false, Invalid: true }

  def active_for_authentication?
    super && (is_deleted == 'Availble')
  end

  def follow(user_id)
    relationship = relationships.new(followed_id: user_id)
    relationship.save
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているかどうか判断する
  def following?(user)
    followings.include?(user)
  end
end
