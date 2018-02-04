class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string  :type
      t.string  :content
      t.integer :notificable_id
      t.string  :notificable_type
      t.timestamps
      t.index [:notificable_id, :notificable_type]
    end
  end
end
