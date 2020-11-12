class CreateTweetComments < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_comments do |t|
      t.string :comment
      t.integer :tweet_id
      t.integer :user_id

      t.timestamps
    end
  end
end
