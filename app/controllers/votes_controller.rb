class VotesController < ApplicationController
  def summary
    @positions = Position.all
  end

  def vote
    candidate = Candidate.find(params[:id])
    Vote.create(candidate: candidate)
    redirect_to position_path(candidate.position), notice: 'Your vote has been cast!'
  end
end

