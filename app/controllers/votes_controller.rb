class VotesController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in before voting
  before_action :ensure_voter_role

  def vote
    candidate = Candidate.find(params[:candidate_id])

    if current_user.voted_for?(candidate.position)
      render json: { error: "You have already voted for this position." }, status: :forbidden
    else
      # Create a new vote
      Vote.create(candidate: candidate, user: current_user, position: candidate.position)

      # Update the candidate's vote count dynamically
      update_vote_count(candidate)

      redirect_to positions_path, notice: "Thank you for voting!"  # Redirect after voting
    end
  end  

  def summary
    @positions = Position.includes(candidates: :votes)  

    @positions.each do |position|
      total_votes = position.candidates.joins(:votes).count
      
      position.candidates.each do |candidate|
        candidate.vote_percentage = total_votes.zero? ? 0 : (candidate.votes.count.to_f / total_votes * 100).round(2)
      end
    end
  end

  private

  def update_vote_count(candidate)
    # Increment the vote count for the candidate
    candidate.increment!(:votes_count)  # Assuming you have a `votes_count` column in your candidates table
  end

  def ensure_voter_role
    redirect_to root_path, alert: "You are not authorized to vote." unless current_user.voter?
  end
end