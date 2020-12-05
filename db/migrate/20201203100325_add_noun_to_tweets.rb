class AddNounToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :noun, :string
  end
end
