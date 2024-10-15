# app/controllers/admin/votes_controller.rb
module Admin
  class VotesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin

    def summary
      @votes = Vote.all.includes(:candidate)  # Fetch all votes; adjust according to your model setup
      # Additional logic for summarizing votes can go here
    end

    private

    def ensure_admin
      unless current_user.admin?
        flash[:alert] = "You are not authorized to access this page."
        redirect_to root_path
      end
    end
  end
end
