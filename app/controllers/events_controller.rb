class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  def index
    @events = Event.all
  end

  def index_my
    @events = Event.where("user_id = ?", current_user)
  end

  def show
    @events = Event.geocoded

    @markers = @events.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude
      }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params_events)
    @event.user = current_user
    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def params_events
    params.require(:event).permit(:date, :details, :place, :game_id)
  end
end



    # @cocktail_new = Cocktail.new
    # if params_search && params_search[:query] != ""
    #   @cocktails = Cocktail.where("name = ?", params_search[:query])
    # else
    #   @cocktails = Cocktail.all
    # end

