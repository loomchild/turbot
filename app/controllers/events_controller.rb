class EventsController < ApplicationController
  PAGE_SIZE = 10

  def index
    @events = Event.order('LOWER(title)')

    @page = page
    @last_page = [@events.count - 1, 0].max / PAGE_SIZE + 1
    @events = @events.limit(PAGE_SIZE).offset(offset)
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def page
    params[:page]&.to_i || 1
  end

  def offset
    (page - 1) * PAGE_SIZE
  end
end
