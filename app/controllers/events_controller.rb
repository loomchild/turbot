class EventsController < ApplicationController
  PAGE_SIZE = 10

  def index
    @events = Event.order('LOWER(title)')

    @query = session[:query] || params[:query]
    @events = @events.where('title LIKE :query OR subtitle LIKE :query OR abstract LIKE :query OR speakers LIKE :query', { query: "%#{@query}%" }) if @query

    @page = page
    @last_page = [@events.count - 1, 0].max / PAGE_SIZE + 1
    @events = @events.limit(PAGE_SIZE).offset(offset)
  end

  def create
    session[:query] = params[:query]

    redirect_to events_path
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
