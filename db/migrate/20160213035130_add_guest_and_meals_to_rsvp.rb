class AddGuestAndMealsToRsvp < ActiveRecord::Migration
  def change
    add_column :rsvps, :guest_name, :string
    add_column :rsvps, :meal_id, :integer
    add_column :rsvps, :guest_meal_id, :integer
  end
end
