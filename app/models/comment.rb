class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  
  validates :user, :photo, :message, presence: true
end
