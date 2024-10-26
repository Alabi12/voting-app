class Admin::CandidatesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin
  before_action :load_positions, only: [:new, :create, :edit, :update]
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  def index
    @candidates = Candidate.all
  end

  def new
    @candidate = Candidate.new
  end

  def show
    # @candidate is set by set_candidate
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to admin_candidates_path, notice: "Candidate created successfully."
    else
      render :new
    end
  end

  def edit
    # @candidate is loaded by the set_candidate callback
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to admin_candidates_path, notice: "Candidate updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to admin_candidates_path, notice: "Candidate deleted successfully." }
      format.json { head :no_content }
    end
  end  

  private

  def candidate_params
    params.require(:candidate).permit(:name, :position_id, :image)
  end

  def ensure_admin
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end

  def load_positions
    @positions = Position.all
  end

  def set_candidate
    @candidate = Candidate.find(params[:id])
  end
end
