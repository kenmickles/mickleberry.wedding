class AddInstagramCodeToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :instagram_code, :string
  end
end
