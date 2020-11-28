class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :vote
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
  end
end
