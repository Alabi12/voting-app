class VotesController < ApplicationController
  def vote
    candidate = Candidate.find(params[:candidate_id])
    Vote.create(candidate: candidate)
    redirect_to position_path(candidate.position), notice: "Your vote for #{candidate.name} has been cast!"
  end

  def summary
    @positions = Position.includes(candidates: :votes)  # Preload candidates and their votes
  end
end
