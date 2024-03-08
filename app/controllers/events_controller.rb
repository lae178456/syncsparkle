require 'httparty'

class EventsController < ApplicationController
  def create
    # Create the event in Rails
    @event = Event.new(event_params)

    if @event.save
      # Create and publish the event on Eventbrite
      create_eventbrite_event(@event)
      redirect_to event_path(@event), notice: 'Event created successfully!'
    else
      render :new
    end
  end

  private

  def create_eventbrite_event(event)
    # Set Eventbrite API endpoint and access token
    url = 'https://www.eventbriteapi.com/v3/organizations/2042762295513/events/'
    access_token = 'UZC3UQCC7BF5J7MYY3JU' # Replace with actual OAuth token

    # Build the request body with event details
    event_data = {
      event: {
        name: { html: event.name },
        start: {
          timezone: 'Europe/Paris', # Adjust timezone as needed
          utc: event.start_time.utc.iso8601 # Convert start time to UTC(standard time reference) and format as ISO8601(date/time format ("2024-03-07T15:00:00"))
        },
        end: {
          timezone: 'Europe/Paris', # Adjust timezone
          utc: event.end_time.utc.iso8601 # Convert end time to UTC and format as ISO8601
        },
        currency: event.currency
      }
    }

    # Make HTTP POST request
    response = HTTParty.post(url,
                              headers: {
                                'Authorization' => "Bearer UZC3UQCC7BF5J7MYY3JU",
                                'Content-Type' => 'application/json'
                              },
                              body: event_data.to_json)

    # Handle response
    if response.success?
      # Event created successfully
      event_data = response.parsed_response
      event.update(eventbrite_id: event_data['id']) # Assuming the response contains the event ID
      puts 'Event created on Eventbrite successfully!'
    else
      # Failed to create event
      puts 'Failed to create event on Eventbrite'
      puts "Error: #{response.code} - #{response.message}"
      puts "Response body: #{response.body}"
    end
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :start_date, :end_date, :online_event, :image)
  end
end
