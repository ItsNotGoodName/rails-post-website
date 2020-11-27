class DropPostVotesTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :post_votes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
