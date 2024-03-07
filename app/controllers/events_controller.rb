class EventsController < ApplicationController
  def index
    @events = Event.all
    # Filter events based on parameters
    @events = @events.where(category: params[:category]) if params[:category].present?
    # Additional filtering logic as needed

     # The `geocoded` scope filters only events with coordinates
    @markers = @draft_events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude
      }
    end
  end

  def show
    @event = Event.find(params[:id])
  end


  def dashboard
    @draft_events = Event.where(status: 'Draft')
    @to_be_modified_events = Event.where(status: 'To be modified')
    @under_review_events = Event.where(status: 'Under Review')
    @published_events = Event.where(status: 'Published')
    @cancelled_events = Event.where(status: 'Cancelled')
    @archived_events = Event.where(status: 'Archived')
  end

  # def draft
    # @events = Event.where(status: 'Draft')
    # render :index
  # end

  #def to_be_modified
    #@events = Event.where(status: 'To be modified')
    #render :index
  #end
end
