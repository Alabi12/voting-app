class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_voter_role

<<<<<<< HEAD
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
=======
  def vote
    candidate = Candidate.find(params[:candidate_id])  # Find the candidate using candidate_id from params

    if current_user.voted_for?(candidate.position)
      render json: { error: "You have already voted for this position." }, status: :forbidden
    else
      create_vote(candidate)

      # Respond to JS to update the vote count dynamically
      respond_to do |format|
        format.js { render 'update_vote_count', locals: { candidate: candidate } }
        format.html { redirect_to positions_path, notice: "Thank you for voting!" }  # Redirect after voting for HTML requests
      end
    end
  end

  def summary
    @positions = Position.includes(candidates: :votes)  # Preload candidates and their votes

    # Calculate total votes and percentage for each candidate
    @positions.each do |position|
      total_votes = position.candidates.sum { |candidate| candidate.votes.count }

      position.candidates.each do |candidate|
        candidate.vote_percentage = calculate_vote_percentage(candidate.votes.count, total_votes)
      end
>>>>>>> fabfc5b2f6564b102358ecb7bd0e505d372e1b64
    end
  end

  private

<<<<<<< HEAD
=======
  def create_vote(candidate)
    Vote.create(candidate: candidate, user: current_user, position: candidate.position)
    update_vote_count(candidate)  # Increment the vote count for the candidate
  end

  def calculate_vote_percentage(candidate_votes, total_votes)
    total_votes.zero? ? 0 : (candidate_votes.to_f / total_votes * 100).round(2)
  end

  def update_vote_count(candidate)
    candidate.increment!(:votes_count)  # Increment the vote count for the candidate
  end

>>>>>>> fabfc5b2f6564b102358ecb7bd0e505d372e1b64
  def ensure_voter_role
    redirect_to root_path, alert: "You are not authorized to vote." unless current_user.voter?
  end
end
