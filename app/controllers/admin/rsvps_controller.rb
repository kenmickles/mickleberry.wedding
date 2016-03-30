class Admin::RsvpsController < Admin::AdminController
  before_action :find_rsvp, only: [:edit, :update, :destroy]

  def index
    @page_title = "RSVPs"
    @rsvps = Rsvp.all.order('id DESC').includes(:meal, :guest_meal)
    @meals = Meal.all.order(:short_name)
    @body_classes = "admin"
  end

  def edit
    @page_title = "Edit RSVP"
  end

  def update
    @rsvp.update(rsvp_params)

    if @rsvp.errors.any?
      render :edit
    else
      redirect_to admin_rsvps_path, notice: "RSVP ##{@rsvp.id} updated successfully."
    end
  end

  def destroy
    if @rsvp.destroy
      redirect_to admin_root_path, notice: "RSVP ##{@rsvp.id} has been deleted."
    else
      redirect_to admin_root_path, alert: "Failed to delete RSVP."
    end
  end

  private

    def find_rsvp
      @rsvp = Rsvp.find(params[:id])
    end

    def rsvp_params
      params.require(:rsvp).permit(:name, :attending, :guest_name, :meal_id, :guest_meal_id, :message)
    end
end