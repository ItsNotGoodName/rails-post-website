class RenameCommentsContentToBody < ActiveRecord::Migration[6.0]
  def self.up
    rename_column :comments, :content, :body
  end
end
