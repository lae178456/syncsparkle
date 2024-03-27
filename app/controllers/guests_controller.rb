class GuestsController < ApplicationController
  before_action :authenticate_user! # Assuming you want to authenticate users before managing guests
  before_action :set_guest, only: [:edit, :update, :destroy]

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

  def edit
    @guest = Guest.find(params[:id])

  end

  def update
    if @guest.update(guest_params)
      redirect_to guests_path, notice: "Guest updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @guest.destroy
    redirect_to guests_path, notice: "Guest deleted successfully"
  end

  private

  def set_guest
    @guest = Guest.find(params[:id])
  end

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :email)
  end
end
