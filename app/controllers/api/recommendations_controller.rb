class Api::RecommendationsController < Api::ApiController
  def index
    @recommendations = Recommendation.order(:name).page(params[:page]).per(10)
  end

  def show
    @recommendation = Recommendation.find(params[:id])
  end
end