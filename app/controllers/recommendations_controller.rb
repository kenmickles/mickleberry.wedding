class RecommendationsController < ApplicationController
  def index
    @page_title = "Recommendations"
    @recommendations = Recommendation.all.order(:name)
  end
end