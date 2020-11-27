class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :value, limit: 1
      t.integer :user_id
      t.integer :voteable_id
      t.string :voteable_type

      t.timestamps
    end
    add_index :votes, %i[user_id voteable_id voteable_type], unique: true
  end
end
