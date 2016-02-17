class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name, null: false
      t.boolean :plus_one, default: false, null: false
      t.timestamps null: false
      t.index :name, unique: true
    end
  end
end
