class VotesController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in before voting
  before_action :ensure_voter_role

  def vote
    candidate = Candidate.find(params[:candidate_id])

    # Check if the user has already voted for a candidate in this position
    if current_user.voted_for?(candidate.position)
      redirect_to position_path(candidate.position), alert: "You have already voted for your favorite candidate."
    else
      # Create the vote
      Vote.create(candidate: candidate, user: current_user, position: candidate.position)

      # Set success flash message
      flash[:notice] = "Your vote for #{candidate.name} has been successfully cast!"

      redirect_to position_path(candidate.position)
    end
  end


  private

  def ensure_voter_role
    redirect_to root_path, alert: "You are not authorized to vote." unless current_user.voter?
  end
  
  def summary
    @positions = Position.includes(candidates: :votes)  # Preload candidates and their votes

    # Calculate total votes for each position
    @positions.each do |position|
      total_votes = position.candidates.joins(:votes).count
      
      position.candidates.each do |candidate|
        candidate.vote_percentage = total_votes.zero? ? 0 : (candidate.votes.count.to_f / total_votes * 100).round(2)
      end
    end
  end
end
