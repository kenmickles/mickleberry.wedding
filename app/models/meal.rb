class Meal < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
