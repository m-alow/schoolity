class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :notifiable, polymorphic: true, index: true
      t.integer :recipient_id
      t.string :recipient_role
      t.integer :actor_id
      t.datetime :read_at

      t.timestamps null: false
    end

    add_foreign_key :notifications, :users, column: :recipient_id, index: true
    add_foreign_key :notifications, :users, column: :actor_id, index: true
  end
end
