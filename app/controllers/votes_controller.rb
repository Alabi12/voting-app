class VotesController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in before voting
  before_action :ensure_voter_role

  def vote
    candidate = Candidate.find(params[:candidate_id])
  
    if current_user.voted_for?(candidate.position)
      render json: { error: "You have already voted for this position." }, status: :forbidden
    else
      Vote.create(candidate: candidate, user: current_user, position: candidate.position)
  
      # Respond to JS to update the vote count dynamically
      respond_to do |format|
        format.js { render 'update_vote_count', locals: { candidate: candidate } }
      end
    end
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

  private

  def ensure_voter_role
    redirect_to root_path, alert: "You are not authorized to vote." unless current_user.voter?
  end
end
