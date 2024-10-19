class DevelopersController < ApplicationController
  before_action :require_admin

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params)
    if @developer.save
      redirect_to admin_dashboard_path, notice: 'Developer created successfully.'
    else
      render :new
    end
  end

  private

  def developer_params
    params.require(:developer).permit(:email, :password, :password_confirmation)
  end

  def require_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user&.admin?
  end
end
