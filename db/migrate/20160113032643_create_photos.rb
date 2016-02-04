class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :caption
      t.string :source_url
      t.string :photographer
      t.attachment :image
      t.timestamps null: false
    end
  end
end
