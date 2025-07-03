class CreateJoinTableMemosTags < ActiveRecord::Migration[8.0]
  def change
    create_join_table :memos, :tags do |t|
      t.index [ :memo_id, :tag_id ]
      t.index [ :tag_id, :memo_id ]
    end
  end
end
