# app/controllers/developer_controller.rb
class DeveloperController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_developer

  def index
    @users = User.all
  end

  def assign_role
    @user = User.find(params[:id])
    if params[:role] == 'admin'
      @user.update(admin: true)
    elsif params[:role] == 'voter'
      @user.update(admin: false)
    end
    redirect_to developer_dashboard_path, notice: "Role updated successfully!"
  end

  private

  def ensure_developer
    redirect_to root_path unless current_user.developer?
  end
end
