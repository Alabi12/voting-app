class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)

    # Assign roles based on the checkboxes
    @user.admin = params[:user][:admin] == '1'
    @user.developer = params[:user][:developer] == '1'

    if @user.save
      flash[:notice] = "Sign up successful. Please log in with your credentials."
      # Redirect to sign-in page after successful signup
      redirect_to new_user_session_path
    else
      render :new # Render the signup page again with error messages
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin, :developer)
  end
end
