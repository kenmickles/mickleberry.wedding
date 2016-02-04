class User < ActiveRecord::Base
  has_attached_file :avatar, styles: { thumb: "160x160#" }, default_url: "default_avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :token, presence: true, uniqueness: true
  has_many :photos
end
