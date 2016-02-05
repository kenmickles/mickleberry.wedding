class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, null: false
      t.references :photo, null: false
      t.text :message, null: false
      t.timestamps null: false
      t.index :photo_id
    end
  end
end
