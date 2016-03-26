class Admin::RsvpsController < Admin::AdminController
  def index
    @rsvps = Rsvp.all.order('id DESC').includes(:meal, :guest_meal)
    @meals = Meal.all.order(:short_name)
    @body_classes = "admin"
  end

  def destroy
    @rsvp = Rsvp.find(params[:id])

    if @rsvp.destroy
      redirect_to admin_root_path, notice: "RSVP ##{@rsvp.id} has been deleted."
    else
      redirect_to admin_root_path, alert: "Failed to delete RSVP."
    end
  end
end