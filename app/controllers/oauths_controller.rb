require 'uri'

class OauthsController < ApplicationController
  def receive
    if params[:code].present?
      session[:event_brite_code] = params[:code]
      redirect_to '/oauth', notice: 'Eventbrite code received successfully and saved in session.'
    else
      session[:event_brite_code] = "None"
    end
  end

  def show
    @event_publish_data = nil

    # restrict this url to receive data only form eventbrite? how??
    if params[:code].present?
      @code = params[:code]
      event_id = params[:event_id]
      @event = Event.find(event_id.to_i)

      # make POST request to eventbrite
      # curl --request POST --url 'https://www.eventbrite.com/oauth/token'
      # --header 'content-type: application/x-www-form-urlencoded'
      #  --data grant_type=authorization_code
      #  --data 'client_id=API_KEY
      #  --data client_secret=CLIENT_SECRET
      #  --data code=ACCESS_CODE
      #  --data 'redirect_uri=REDIRECT_URI']
      data = {
        grant_type: "authorization_code",
        client_id: ENV["CLIENT_ID"],
        client_secret: ENV["CLIENT_SECRET"],
        code: params[:code]
      }
      response = HTTParty.post("https://www.eventbrite.com/oauth/token",
                               body: URI.encode_www_form(data),
                               headers: {
                                 'Content-Type' => 'application/x-www-form-urlencoded'
                               }
      )
      @response_body = JSON.parse(response.body)
      session[:event_brite_code] = @response_body

      token = @response_body["access_token"]

      my_orgs = HTTParty.get("https://www.eventbriteapi.com/v3/users/me/organizations/",
                             headers: {
                               'Content-Type' => 'application/json',
                               'Authorization' => "Bearer #{token}"
                             }
      )
      @myorgs = JSON.parse(my_orgs.body)
      organisation_id = @myorgs["organizations"][0]["id"]

      event_data = {
        event: {
          name: { html: "<p>#{@event.title}</p>" },
          description: { html: "<p>#{@event.description}</p>" },
          start: { timezone: "UTC", utc: @event.start_date.strftime("%Y-%m-%dT%H:%M:%SZ") },
          end: { timezone: "UTC", utc: @event.end_date.strftime("%Y-%m-%dT%H:%M:%SZ") },
          currency: "EUR",
          online_event: "#{@event.online_event}",
          listed: false,
          shareable: false,
          invite_only: false,
          show_remaining: true,
          password: "",
          capacity: 100,
          is_reserved_seating: false,
          is_series: false,
          show_pick_a_seat: false,
          show_seatmap_thumbnail: false,
          show_colors_in_seatmap_thumbnail: false,
          locale: "de_AT"
        }
      }

      # Post an event
      @event_request = HTTParty.post("https://www.eventbriteapi.com/v3/organizations/#{organisation_id}/events/",
                                     body: JSON.generate(event_data),
                                     headers: {
                                       'Content-Type' => 'application/json',
                                       'Authorization' => "Bearer #{token}"
                                     }
      )

      eventbrite_event_id = @event_request["url"].split("-")[-1]

      # Create ticket class data take it from event
      ticket_data = {
        ticket_class: {
          name: 'General Admission',
          description: 'General Admission Ticket',
          quantity_total: 100,
          free: true
        }
      }

      # POST request to create ticket class
      response = HTTParty.post("https://www.eventbriteapi.com/v3/events/#{eventbrite_event_id}/ticket_classes/",
                                body: JSON.generate(ticket_data),
                                headers: {
                                  'Content-Type' => 'application/json',
                                  'Authorization' => "Bearer #{token}"
                                }
      )

      if response.success?
        # Ticket class created successfully
        ticket_class_data = JSON.parse(response.body)
        @ticket_class_id = ticket_class_data['id']

        # Publish an event
        event_publish_request = HTTParty.post("https://www.eventbriteapi.com/v3/events/#{eventbrite_event_id}/publish/",
                                              headers: {
                                                'Content-Type' => 'application/json',
                                                'Authorization' => "Bearer #{token}"
                                              }
        )

        # Event published successfully
        @event_publish_data = JSON.parse(event_publish_request.body)


      end
    end
  end

end
