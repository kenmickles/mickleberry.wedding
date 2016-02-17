class RemoveAttendingFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :attending
  end
end
