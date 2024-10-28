class Admin::VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def summary
    @votes = Vote.includes(:candidate, :position)
    @total_votes = Vote.count
    @total_candidates = Candidate.count
    @positions = Position.includes(candidates: :votes) # Make sure to include necessary associations
    @total_voters = User.where(role: 'voter').count
    @votes_by_candidate = @votes.group_by(&:candidate_id).transform_values(&:count)
  end

    # This action resets all votes for a new election cycle.
    def reset_votes
      ActiveRecord::Base.transaction do
        # Clear all votes from the Vote model
        Vote.delete_all
       # Clear users with a 'voter' role (assuming you have a role column or similar setup)
       User.where(role: 'voter').delete_all

    # Reset the votes_count for each candidate to 0
       Candidate.update_all(votes_count: 0)

      redirect_to admin_dashboard_path, notice: "Voting system has been reset for a new election."
    end
  end

  private

  def ensure_admin
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.admin?
  end
      # Ensure that only admins can access this action
      def ensure_admin_role
        redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.admin?
      end
end
