class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image
  has_many :tweets, dependent: :destroy
  has_many :tweet_comments, dependent: :destroy
  has_many :tweet_favorites, dependent: :destroy
  has_many :comment_favorites, dependent: :destroy
end
