class GuestsController < ApplicationController
  before_action :authenticate_user! # Assuming you want to authenticate users before managing guests

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    @guest.user = current_user
    if @guest.save
      # Handle successful creation
      redirect_to guests_path, notice: "Guest created successfully"
    else
      # Handle errors
      render :new
    end
  end

  def index
    @guests = Guest.all
  end

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :email)
  end
end
