json.extract! @rsvp, :id, :name, :guest_name, :email, :message, :attending, :meal_id, :guest_meal_id
json.plus_one @rsvp.plus_one?