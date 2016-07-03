class RemoveActorIdFromNotifications < ActiveRecord::Migration
  def up
    remove_column :notifications, :actor_id, :integer
  end

  def down
    add_column :notifications, :actor_id, :integer
    add_foreign_key :notifications, :users, column: :recipient_id, index: true
  end
end
