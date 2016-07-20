class CreateDeviceTokens < ActiveRecord::Migration
  def change
    create_table :device_tokens do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :token

      t.timestamps null: false
    end
    add_index :device_tokens, [:user_id, :token], unique: true
  end
end
