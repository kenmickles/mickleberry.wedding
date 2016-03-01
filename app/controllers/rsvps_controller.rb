class RsvpsController < ApplicationController
  before_action :setup_rsvp

  def new
  end

  def guest
  end

  def meal
    @meals = Meal.all.order(:name)
  end

  def message
  end

  def thanks
  end

  def sorry
  end

  def create
    save_and_redirect
  end

  def update
    save_and_redirect
  end

  protected

  def setup_rsvp
    if params[:new].present?
      session[:rsvp_id] = nil
      redirect_to new_rsvp_path
    end
    
    @page_title = "RSVP"
    @rsvp = Rsvp.find_or_initialize_by(id: session[:rsvp_id]) 
  end

  def rsvp_params
    params.require(:rsvp).permit(:name, :email, :attending, :message, :guest_name, :meal_id, :guest_meal_id)
  end

  def previous_action
    @previous_action ||= begin
      actions = %w(new guest meal message thanks)

      if actions.include?(params[:previous_action])
        params[:previous_action]
      else
        actions.first
      end
    end
  end

  def save_and_redirect
    @rsvp.update(rsvp_params)

    if @rsvp.errors.any?
      render @tab
    else
      session[:rsvp_id] = @rsvp.id

      if !@rsvp.attending?
        next_path = rsvp_sorry_path
      elsif previous_action == 'new' && (@rsvp.plus_one? || @rsvp.guest_name.present?)
        next_path = rsvp_guest_path
      elsif %w(new guest).include?(previous_action)
        next_path = rsvp_meal_path
      elsif previous_action == 'message' && rsvp_params[:message].present?
        next_path = rsvp_thanks_path
      else
        next_path = rsvp_message_path
      end

      redirect_to next_path
    end
  end
end