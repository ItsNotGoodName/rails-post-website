class ChangeVoteToPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :vote, :integer, default: 0
  end
end
