class CandidatesController < ApplicationController
  before_action :set_position
  before_action :authenticate_user!

  def vote
    @candidate = Candidate.find(params[:id])
    
    # You can customize this to prevent duplicate voting, etc.
    if current_user.voted_for?(@candidate) 
      redirect_to candidates_path, alert: "You have already voted for this candidate."
    else
      @candidate.increment!(:votes) # Assumes you have a `votes` column in the candidates table
      current_user.mark_as_voted(@candidate) # You need to track this in your user model
      redirect_to candidates_path, notice: "Thank you for voting!"
    end
  end
  
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
    params.require(:candidate).permit(:name, :image)  # Allow the image parameter
  end
end
