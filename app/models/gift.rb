class Gift < ActiveRecord::Base
  has_attached_file :image, styles: { thumb: "160x160#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true

  def image_from_url(url)
    self.image = URI.parse(url)
  end

  def registry
    "Amazon" if link.try(:match, /amazon\.com/)
  end
end
