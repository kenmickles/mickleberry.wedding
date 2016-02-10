class RsvpsController < ApplicationController
  def new
    @page_title = "RSVP"
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.create(rsvp_params)

    if @rsvp.errors.any?
      render :new
    else
      flash[:notice] = "RSVP received successfully :)"

      if @rsvp.attending?
        redirect_to rsvps_thanks_path
      else
        redirect_to rsvps_sorry_path
      end
    end
  end

  def sorry
  end

  def thanks
  end

  protected

  def rsvp_params
    params.require(:rsvp).permit(:name, :email, :attending, :message)
  end
end