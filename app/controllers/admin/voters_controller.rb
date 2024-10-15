class Admin::VotersController < ApplicationController
  before_action :authenticate_user!
  # before_action :admin_only
  before_action :ensure_admin

  def index
    @voters = User.all
  end

  def new
    @voter = User.new
  end
  
  def create
    @voter = User.new(voter_params)
    @voter.role = 'voter'
    @voter.password = generate_password  # Generate a random password for the voter
    if @voter.save
      # Optionally, send the credentials to the voter's email
      flash[:notice] = "Voter created with credentials: #{@voter.email} / #{@voter.password}"
      redirect_to admin_voters_path
    else
      render :new
    end
  end

  private

  def voter_params
    params.require(:user).permit(:email)
  end

  def ensure_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end

  # def admin_only
  #   redirect_to root_path, alert: "Access denied" unless current_user.admin?
  # end

  def generate_password
    SecureRandom.alphanumeric(8)  # Generate an 8-character random password
  end
end
