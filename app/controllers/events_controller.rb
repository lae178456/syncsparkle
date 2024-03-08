class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def index
  end
end
