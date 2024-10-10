class CandidatesController < ApplicationController
  before_action :set_position

  def new
    @candidate = @position.candidates.build
  end

  def create
    @candidate = @position.candidates.build(candidate_params)
    
    if @candidate.save
      redirect_to @position, notice: 'Candidate was successfully created.'
    else
      render :new
    end
  end

  private

  def set_position
    @position = Position.find(params[:position_id])
  end

  def candidate_params
    params.require(:candidate).permit(:name, :image_url, :votes_count)
  end
end
