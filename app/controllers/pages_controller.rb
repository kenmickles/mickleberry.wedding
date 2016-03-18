class PagesController < ApplicationController
  def home
  end

  def venue
    @page_title = "Venue"
    @venue = Recommendation.find_by(name: "Front & Palmer")
  end

  def hotels
    @page_title = "Hotels & Accommodations"
  end
end