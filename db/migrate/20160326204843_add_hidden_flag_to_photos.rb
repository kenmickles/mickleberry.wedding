class AddHiddenFlagToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :hidden, :boolean, null: false, default: false
    add_index :photos, :hidden
  end
end
