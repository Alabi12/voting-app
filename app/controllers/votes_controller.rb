class VotesController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in before voting

  def vote
    candidate = Candidate.find(params[:candidate_id])

    if current_user.voted_for?(candidate.position)
      redirect_to position_path(candidate.position), alert: "You have already voted in this position."
    else
      # Create the vote
      Vote.create(candidate: candidate, user: current_user, position: candidate.position)

      # Update the vote count
      candidate.increment!(:vote_count)

      redirect_to position_path(candidate.position), notice: "Your vote for #{candidate.name} has been cast!"
    end
  end

  def summary
    @positions = Position.includes(candidates: :votes)  # Preload candidates and their votes
  end
end
