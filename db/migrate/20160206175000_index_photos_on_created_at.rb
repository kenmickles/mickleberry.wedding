class IndexPhotosOnCreatedAt < ActiveRecord::Migration
  def change
    add_index :photos, :created_at
  end
end
