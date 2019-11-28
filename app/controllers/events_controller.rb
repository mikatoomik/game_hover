class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :add_player]
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

  def add_player
    @invit = UserEvent.new
    @invit.event = @event
    @invit.user = current_user
    if @invit.save
      redirect_to event_path, :notice => 'You are added to the game'
    else
      redirect_to event_path, :alert => 'Something go wrong!'
    end
  end

  def decline
    @invit = UserEvent.where("user_id = ? AND event_id = ?", current_user, params[:id])
    if !@invit.empty?
      if @invit[0].delete
        redirect_to event_path, :alert => 'You have decline'
      else
        render "index", :alert => 'Something go wrong!'
      end
    end
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

