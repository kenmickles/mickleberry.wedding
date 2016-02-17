class Api::MealsController < Api::ApiController
  def index
    @meals = Meal.all.order(:name)
  end
end