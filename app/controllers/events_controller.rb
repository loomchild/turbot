class EventsController < ApplicationController
  PAGE_SIZE = 10

  def index
    @events = Event.order('LOWER(title)')

    @query = params[:query]
    @events = @events.where('title LIKE :query OR subtitle LIKE :query OR abstract LIKE :query OR speakers LIKE :query', { query: "%#{@query}%" }) if @query

    @page = page
    @last_page = [@events.count - 1, 0].max / PAGE_SIZE + 1
    @events = @events.limit(PAGE_SIZE).offset(offset)
  end

  def create
    last_event = Event.order(id: :desc).limit(1)[0]
    number = last_event.id + 1

    Event.create!(title: "Event #{number}")

    last_page = (Event.count - 1) / PAGE_SIZE + 1
    redirect_to events_path(page: last_page)
  end

  def show
    @event = Event.find(params[:id])
    @next_event = Event.where('id > ?', params[:id])[0]
  end

  private

  def page
    params[:page]&.to_i || 1
  end

  def offset
    (page - 1) * PAGE_SIZE
  end
end
