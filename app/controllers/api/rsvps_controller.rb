class Api::RsvpsController < Api::ApiController
  before_action :require_token!

  def show
    @rsvp = current_rsvp
  end

  def create
    save_and_show
  end

  def update
    save_and_show
  end

  protected

  def save_and_show
    @rsvp = current_rsvp
    @rsvp.update!(rsvp_params)
    render :show
  end

  def current_rsvp
    current_user.rsvp || current_user.build_rsvp(name: current_user.name)
  end

  def rsvp_params
    params.require(:rsvp).permit(:name, :email, :message, :attending, :guest_name, :meal_id, :guest_meal_id)
  end
end