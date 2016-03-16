class Recommendation < ActiveRecord::Base
  enum category: [ :restaurant, :attraction, :hotel, :home ]
  has_attached_file :image, styles: { thumb: "160x160#", medium: "750x500#" }

  validates :name, presence: true
  validates :category, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  geocoded_by :address
  after_validation :geocode, if: -> (r) { r.needs_geocoding? }

  def google_maps_link
    "https://maps.google.com?q=#{URI.encode(address)}"
  end

  def map_hash
    {
      id: id,
      category: category,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      link: link,
      thumbnail: ActionController::Base.helpers.asset_url(image.url(:thumb)),
      google_maps_link: google_maps_link
    }
  end

  protected

  def needs_geocoding?
    (latitude.blank? || longitude.blank?) || (address_changed? && !latitude_changed?)
  end
end
