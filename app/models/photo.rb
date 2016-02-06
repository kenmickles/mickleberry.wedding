class Photo < ActiveRecord::Base
  enum source: [ :instagram, :app ]
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_attached_file :image, styles: { medium: "750x750>" }
  
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_uniqueness_of :instagram_id, allow_blank: true

  def photographer
    super || user.try(:name) || "Somebody"
  end

  def avatar
    super || (user ? user.avatar.url(:thumb) : nil) || "default_avatar.png"
  end
end
