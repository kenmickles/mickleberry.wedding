class Photo < ActiveRecord::Base
  enum source: [ :instagram, :app ]
  has_attached_file :image, styles: { medium: "750x750>" }
  
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_uniqueness_of :instagram_id, allow_blank: true

  scope :visible, -> { where(hidden: false) }

  def photographer
    super || "Somebody"
  end

  def avatar
    super || "default_avatar.png"
  end

  def instagram_link
    "https://www.instagram.com/p/#{instagram_code}" if instagram_code.present?
  end

  def caption_without_tags
    @caption_without_tags ||= caption.to_s.gsub(/\B[#]\S+\b/, '')
  end
end
