class Meal < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  def selection_count
    @selection_count ||= Rsvp.where(attending: true, meal_id: id).count + Rsvp.where(attending: true, guest_meal_id: id).count if persisted?
  end
end
