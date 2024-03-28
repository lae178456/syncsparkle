require 'httparty'

class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def index
    @events = current_user.events
    @past_events_count = Event.where('end_date < ?', Date.today).count
    if params[:query].present?
      @query = params[:query]
      @events = @events.where("title LIKE ?", "%#{params[:query]}%")
    end
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
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "event_details",   # Name of the PDF file to generate (without the .pdf extension)
        template: "events/show"
      end
    end
    api_key = ENV['API_KEY']

    redirect_url = "https://#{ENV['HOST']}/oauth/?event_id=#{@event.id}"
    # https://www.eventbrite.com/oauth/authorize?response_type=code&client_id=YOUR_API_KEY&redirect_uri=YOUR_REDIRECT_URI
    @eventbrite_oauth_link = "https://www.eventbrite.com/oauth/authorize?response_type=code&client_id=#{api_key}&redirect_uri=#{redirect_url}"
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    if @event
      @event.destroy
      redirect_to events_path, status: :see_other
    else
      flash[:error] = "Event not found"
      redirect_to events_path
    end
  end

  def create
  @event = Event.new(event_params)
  @event.user = current_user

  if @event.save
    create_event_listing
    redirect_to '/events', notice: 'Event was successfully created.'
  else
    render :new, status: :unprocessable_entity
  end
  end

  def events_views
    @total_views = Eventlistings.sum(:views)
  end

  private


  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :start_date, :end_date, :online_event, :url, :categories, :user_id, :photo, :hashtags => [])
  end

  def create_event_listing
    @event.eventlistings.create(plattform_id: 1, views: rand(1..100))
  end

end


#def create
  #@event = Event.new(event_params)
  #@event.user = current_user
  #if @event.save
    #redirect_to '/events', notice: 'Event was successfully created.'
  #else
    #render :new, status: :unprocessable_entity
  #end
#end
