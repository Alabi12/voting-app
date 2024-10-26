class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_voter_role

  def create
    @position = Position.find(params[:position_id])
    @candidate = Candidate.find(params[:candidate_id])

    # Check if the user has already voted for this position
    if current_user.voted_for?(@position)
      redirect_to @position, alert: "You've already voted for this position."
    else
      # Create a new vote for the candidate
      create_vote(@candidate)
      redirect_to @position, notice: "Thank you for your vote!"
    end
  end

  def vote
    @candidate = Candidate.find(params[:candidate_id])

    # Check if the user has already voted for this candidate's position
    if current_user.voted_for?(@candidate.position)
      render json: { error: "You have already voted for this position." }, status: :forbidden
    else
      create_vote(@candidate)

      # Respond to JS for dynamic update, or redirect for HTML
      respond_to do |format|
        format.js { render 'update_vote_count', locals: { candidate: @candidate } }
        format.html { redirect_to positions_path, notice: "Thank you for voting!" }
      end
    end
  end

  def summary
    @positions = Position.includes(candidates: :votes)

    # Calculate total votes and percentage for each candidate
    @positions.each do |position|
      total_votes = position.candidates.sum { |candidate| candidate.votes.count }
      position.candidates.each do |candidate|
        candidate.vote_percentage = calculate_vote_percentage(candidate.votes.count, total_votes)
      end
    end
  end

  private

  def create_vote(candidate)
    # Create a new vote associated with the candidate and the current user
    Vote.create(candidate: candidate, user: current_user)
    update_vote_count(candidate)  # Increment the vote count for the candidate
  end

  def calculate_vote_percentage(candidate_votes, total_votes)
    total_votes.zero? ? 0 : (candidate_votes.to_f / total_votes * 100).round(2)
  end

  def update_vote_count(candidate)
    candidate.increment!(:votes_count)  # Increment the vote count for the candidate
  end

  def ensure_voter_role
    redirect_to root_path, alert: "You are not authorized to vote." unless current_user.voter?
  end
end
