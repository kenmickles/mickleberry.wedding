class RemoveUsers < ActiveRecord::Migration
  def change
    drop_table :users
    remove_column :photos, :user_id
    remove_column :rsvps, :user_id
  end
end
