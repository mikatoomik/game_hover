class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:query].present?
      @games = Game.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @games = Game.all
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params_games)
    if @game.save
      redirect_to games_path
    else
      render :new
    end
  end

  private

  def params_games
    params.require(:game).permit(:name, :rules, :photo, :player_max)
  end

end
