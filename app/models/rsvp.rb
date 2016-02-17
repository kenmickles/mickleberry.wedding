class Rsvp < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user
  belongs_to :meal
  belongs_to :guest_meal, class_name: "Meal"
  
  after_save :update_user_name

  def plus_one?
    !!Guest.search(name).try(:plus_one?) if name.present?
  end

  def first_name
    name.strip.split(' ').first if name.present?
  end

  def guest_first_name
    guest_name.strip.split(' ').first if guest_name.present?
  end

  protected

  def update_user_name
    user.update(name: name) if user.present? && user.name != name
  end
end
