# app/controllers/admin/summary_controller.rb
class Admin::SummaryController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    # You can customize this logic depending on what kind of summary you need.
    @total_voters = User.where(role: 'voter').count
    @total_candidates = Candidate.count
    @total_votes = Vote.count

    # Example: group votes by candidate
    @votes_by_candidate = Candidate.joins(:votes).group(:name).count
  end

  private

  def ensure_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
