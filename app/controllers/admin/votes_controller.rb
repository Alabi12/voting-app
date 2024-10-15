class Admin::VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def summary_pdf
    @votes = Vote.includes(:candidate, :position)  # Make sure to fetch the necessary data

    respond_to do |format|
      format.pdf do
        render pdf: "vote_summary",                # The filename of the PDF
               template: "admin/votes/summary.pdf.erb",  # The path to the template
               layout: 'pdf'                        # Use the PDF layout, if you have one
      end
    end
  end
  
  def summary
    @votes = Vote.all.includes(:candidate, :position) # Adjust this as necessary
  end

  private

  def ensure_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
