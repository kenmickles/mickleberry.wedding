class AddNewPhotoFieldsForInstagram < ActiveRecord::Migration
  def change
    add_column :photos, :avatar, :string
    add_column :photos, :source, :integer
    add_column :photos, :instagram_id, :string
    add_index :photos, :instagram_id
  end
end
