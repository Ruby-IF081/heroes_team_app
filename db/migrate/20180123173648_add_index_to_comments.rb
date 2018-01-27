class AddIndexToComments < ActiveRecord::Migration[5.1]
  def change
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :user_id
  end
end
