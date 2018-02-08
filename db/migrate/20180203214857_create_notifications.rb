class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string  :status
      t.boolean :readed, default: false
      t.string  :content
      t.integer :user_id
      t.integer :notificable_id
      t.string  :notificable_type
      t.index :user_id
      t.index :notificable_id
      t.index :notificable_type
      t.timestamps
    end
  end
end
