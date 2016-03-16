class RemoveAppModels < ActiveRecord::Migration
  def change
    drop_table :gifts
    drop_table :comments
  end
end
