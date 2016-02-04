class RenameDeviceUuidToToken < ActiveRecord::Migration
  def change
    rename_column :users, :device_uuid, :token
  end
end
