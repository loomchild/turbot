class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @next_event = Event.where('id > ?', params[:id])[0]
  end
end
