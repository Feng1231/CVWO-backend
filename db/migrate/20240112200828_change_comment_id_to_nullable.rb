class ChangeCommentIdToNullable < ActiveRecord::Migration[7.1]
  def change
    change_column :comments, :comment_id, :bigint, null: true
  end
end
