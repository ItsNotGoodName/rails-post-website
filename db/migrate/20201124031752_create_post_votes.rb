class CreatePostVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :post_votes do |t|
      t.integer :post_id
      t.integer :user_id
      t.boolean :upvote

      t.timestamps
    end
    add_index :post_votes, %i[user_id post_id], unique: true
  end
end
