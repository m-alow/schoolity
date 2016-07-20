class AddRoleToDeviceToken < ActiveRecord::Migration
  def change
    add_column :device_tokens, :role, :string
  end
end
