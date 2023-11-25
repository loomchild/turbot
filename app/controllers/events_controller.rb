class EventsController < ApplicationController
  PAGE_SIZE = 10

  before_action :set_page, only: [:index, :create]

  def index
    @query = session[:query]

    @events = Event.limit(PAGE_SIZE).offset(offset)

    @events = @events.where('title LIKE ?', "%#{@query}%") if @query
  end

  def show
    @event = Event.find(params[:id])
    @next_event = Event.where('id > ?', params[:id])[0]
  end

  def create
    session[:query] = params[:query]

    redirect_to events_path
  end

  private

  def set_page
    @page = params[:page]&.to_i || 1
    @max_page = (Event.count - 1) / PAGE_SIZE + 1 # TODO: not good: how it will work with search? => maybe finally move to index method, maybe @next_page and @prev_page
  end

  def offset
    (@page - 1) * PAGE_SIZE
  end
end
