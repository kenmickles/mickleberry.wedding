class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :name, null: false
      t.string :email
      t.text :message
      t.boolean :attending, default: true, null: false
      t.references :user
      t.timestamps null: false
      t.index :name
    end
  end
end
