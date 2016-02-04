class Photo < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "750x750>" }
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  belongs_to :user

  def image_from_url(url)
    self.image = URI.parse(url)
  end

  def photographer
    super || user.try(:name)
  end

  def avatar
    user ? user.avatar.url(:thumb) : "default_avatar.png"
  end
end
