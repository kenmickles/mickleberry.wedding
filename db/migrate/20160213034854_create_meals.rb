class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps null: false
      t.index :name
    end
  end
end
