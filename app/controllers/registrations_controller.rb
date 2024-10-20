class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params) # Ensure parameters are being passed correctly

    # Assign roles based on the checkboxes
    @user.admin = params[:user][:admin] == '1'
    @user.developer = params[:user][:developer] == '1'

    if @user.save
      flash[:notice] = "Welcome! You have signed up successfully."
      # Redirect based on role
      if @user.admin?
        redirect_to admin_dashboard_path
      elsif @user.developer?
        redirect_to developer_dashboard_path
      else
        redirect_to positions_path # Regular users
      end
    else
      render :new # This will render the new view and show the errors
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin, :developer)
  end
end
