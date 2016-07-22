class AddEnabledToDeviceTokens < ActiveRecord::Migration
  def change
    add_column :device_tokens, :enabled, :boolean
  end
end
