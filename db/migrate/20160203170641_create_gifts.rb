class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name, null: false
      t.text :description
      t.string :link
      t.boolean :purchased, default: false
      t.attachment :image
      t.timestamps null: false

      t.index :name
      t.index :purchased
    end
  end
end
