class Guest < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  def self.search(str)
    where('LOWER(name)=LOWER(?)', str).first
  end
end
