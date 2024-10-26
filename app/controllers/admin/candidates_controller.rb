# app/controllers/admin/candidates_controller.rb
class Admin::CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]
  before_action :set_positions, only: [:new, :edit]

  def index
    @candidates = Candidate.all
  end

  def new
    @candidate = Candidate.new
  end

  def show
    # @candidate is set in the before_action
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to admin_candidates_path, notice: 'Candidate created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to admin_candidates_path, notice: 'Candidate updated successfully.'
    else
      render :edit, alert: 'Failed to update candidate.'
    end
  end
  
  def destroy
    @candidate.destroy
    redirect_to admin_candidates_path, notice: 'Candidate was successfully deleted.'
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_candidates_path, alert: "Candidate not found."
  end

  def set_positions
    @positions = Position.all
  end

  def candidate_params
    params.require(:candidate).permit(:name, :position_id, :image)
  end
end
