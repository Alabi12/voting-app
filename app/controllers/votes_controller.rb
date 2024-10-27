class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_voter, only: [:create]


  def vote
    @candidate = Candidate.find(params[:candidate_id])

    # Check if the user has already voted for this position to avoid duplicate votes
    if current_user.votes.exists?(position: @candidate.position)
      # Redirect with an alert if the user has already voted
      redirect_to positions_path, alert: "You have already voted for this position."
    else
      Vote.create(candidate: @candidate, user: current_user, position: @candidate.position)
      @candidate.increment!(:votes_count)  # Ensure vote increments only once

      respond_to do |format|
        format.turbo_stream  # Turbo Stream response to update the count in real time
        format.html { redirect_to positions_path, notice: "Thank you for voting!" }
      end
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


  def ensure_voter_role

  def authorize_voter
    # Check if the current user is authorized to vote

    redirect_to root_path, alert: "You are not authorized to vote." unless current_user.voter?
  end
end
