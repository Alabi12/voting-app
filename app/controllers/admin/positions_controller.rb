class Admin::PositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @positions = Position.all
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new(position_params)
    if @position.save
      redirect_to admin_positions_path, notice: 'Position was successfully created.'
    else
      render :new
    end
  end

  def edit
    @position = Position.find(params[:id])
  end

  def show
    @position = Position.find(params[:id])
  end

  def update
    @position = Position.find(params[:id])
    if @position.update(position_params)
      redirect_to admin_positions_path, notice: 'Position was successfully updated.'
    else
      render :edit
    end
  end

 def destroy
  @position = Position.find(params[:id])
  
  if @position.destroy
    flash[:notice] = "Position deleted successfully."
  else
    flash[:alert] = "Position could not be deleted."
  end
  
  redirect_to admin_positions_path
end

  private

  def position_params
    params.require(:position).permit(:name)
  end

  def admin_only
    unless current_user.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end
