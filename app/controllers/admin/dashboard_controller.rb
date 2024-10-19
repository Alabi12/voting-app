# app/controllers/admin/dashboard_controller.rb
module Admin
  class DashboardController < ApplicationController
    before_action :require_admin

    def index
      # Example logic to load data for the dashboard
      @positions = Position.all
      @candidates = Candidate.all
      @voters = User.voters # Assuming you have a method or scope to get voters
    end

    private

    def require_admin
      redirect_to root_path, alert: 'Access denied.' unless current_user&.admin?
    end
  end
end
