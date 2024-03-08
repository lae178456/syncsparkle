class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_event, only: [:edit, :destroy, :show]

  def new
    @event = Event.new
  end

  def index
    @events = Event.all
    @past_events_count = Event.where('end_date < ?', Date.today).count
    if params[:query].present?
      @query = params[:query]
      @events = Event.where("title LIKE ?", "%#{params[:query]}%")
    else
      @events = Event.all
    end
  end

  def past_events
    Event.where('end_date < ?', Date.today)
  end

  def upcoming_events
    Event.where('end_date >= ?', Date.today)
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to '/events', notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event.destroy
    redirect_to events_path, status: :see_other
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :start_date, :end_date, :start_time, :end_time, :online_event, :url, :categories, hashtags: [])
  end

end
