class Recommendation < ActiveRecord::Base
  enum category: [ :restaurant, :attraction, :hotel ]
  has_attached_file :image, styles: { medium: "750x500#" }

  validates :name, presence: true
  validates :category, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  geocoded_by :address
  after_validation :geocode, if: -> (r) { r.needs_geocoding? }

  def image_from_url(url)
    self.image = URI.parse(url)
  end

  protected

  def needs_geocoding?
    (latitude.blank? || longitude.blank?) || (address_changed? && !latitude_changed?)
  end
end
