class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :name, null: false
      t.text :description
      t.integer :category
      t.string :address
      t.string :link
      t.attachment :image
      t.decimal :latitude, precision: 15, scale: 10
      t.decimal :longitude, precision: 15, scale: 10
      t.timestamps null: false

      t.index :name
    end
  end
end