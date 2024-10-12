class PositionsController < ApplicationController
  # before_action :authenticate_user!, only: [:vote, :new, :create]
  def index
    @positions = Position.all
  end

  def show
      @position = Position.find(params[:id])
      @candidates = @position.candidates.includes(:votes)  # Preload votes for candidates
  end
end
