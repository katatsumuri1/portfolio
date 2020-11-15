class CommentFavorite < ApplicationRecord
    belongs_to :tweet_comment
    belongs_to :user
end
