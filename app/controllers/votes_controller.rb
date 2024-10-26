class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_voter_role

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

  def vote
    candidate = Candidate.find(params[:candidate_id])

    if current_user.voted_for?(candidate.position)
      redirect_to positions_path, alert: "You have already voted for this position."
    else
      Vote.create(candidate: candidate, user: current_user, position: candidate.position)
      candidate.increment!(:votes_count)  # Increment the vote count

      redirect_to positions_path, notice: "Thank you for voting!"
    end
  end

  private

  def ensure_voter_role
    redirect_to root_path, alert: "You are not authorized to vote." unless current_user.voter?
  end
end
