class AddAttendingFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :attending, :boolean, default: true
  end
end
