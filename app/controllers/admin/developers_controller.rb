class Admin::DevelopersController < ApplicationController
  def new
    @developer = User.new # Assuming you're using the User model for developers
  end

  def create
    @developer = User.new(developer_params)
    @developer.role = 'developer' # Set role to 'developer'
    if @developer.save
      redirect_to admin_dashboard_path, notice: 'Developer created successfully.'
    else
      render :new
    end
  end

  private

  def developer_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def require_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user&.admin?
  end
end
