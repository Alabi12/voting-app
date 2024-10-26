class Admin::VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def summary
    @votes = Vote.includes(:candidate, :position)
    @total_votes = Vote.count
    @total_candidates = Candidate.count
    @total_voters = User.where(role: 'voter').count
    @votes_by_candidate = @votes.group_by(&:candidate_id).transform_values(&:count)
  end

  private

  def ensure_admin
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.admin?
  end
end
