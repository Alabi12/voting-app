class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_voter, only: [:create]

  def create
    @position = Position.find(params[:position_id])
    @candidate = Candidate.find(params[:candidate_id])

    if current_user.voted_for?(@position)
      redirect_to @position, alert: "You've already voted for this position."
    else
      @candidate.votes.create(user: current_user) # Assuming a Vote model exists
      redirect_to @position, notice: "Thank you for your vote!"
    end
  end

  private

  def authorize_voter
    # Check if the current user is authorized to vote
    redirect_to root_path, alert: "You are not authorized to vote." unless current_user.voter?
  end
end
