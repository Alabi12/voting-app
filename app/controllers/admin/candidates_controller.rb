class Admin::CandidatesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @candidates = Candidate.all
  end

  def new
    @candidate = Candidate.new
    @positions = Position.all  # Ensure positions are available for selection
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to admin_candidates_path, notice: "Candidate updated successfully."
    else
      # Add this line to debug
      flash.now[:alert] = @candidate.errors.full_messages.join(", ")
      render :edit
    end
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to admin_candidates_path, notice: "Candidate created successfully."
    else
      render :new
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :position_id, :image)  # Permit image parameter
  end

  def ensure_admin
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end
