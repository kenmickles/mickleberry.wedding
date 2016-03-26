class Rsvp < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :meal
  belongs_to :guest_meal, class_name: "Meal"

  def plus_one?
    !!Guest.search(name).try(:plus_one?) if name.present?
  end

  def first_name
    name.strip.split(' ').first if name.present?
  end

  def guest_first_name
    guest_name.strip.split(' ').first if guest_name.present?
  end

  def self.guest_count
    count = 0 

    Rsvp.where(attending: true).each do |rsvp|
      if rsvp.guest_name.present?
        count += 2
      else
        count += 1
      end
    end

    count
  end
end
