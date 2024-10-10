class PositionsController < ApplicationController
  def index
    @positions = Position.all
  end

  def show
      @position = Position.find(params[:id])
      @candidates = @position.candidates.includes(:votes)  # Preload votes for candidates
  end
end
