class AddArchivedToMemos < ActiveRecord::Migration[8.0]
  def change
    add_column :memos, :archived, :boolean, default: false
  end
end
