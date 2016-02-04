class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :device_uuid, null: false
      t.timestamps null: false
      t.index :device_uuid, unique: true
    end
  end
end
