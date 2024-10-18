class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(user_params)

    if @user.developer
      if verify_developer(@user.verification_code)
        if @user.save
          redirect_to admin_dashboard_path, notice: "Signed up successfully." # Redirect to admin dashboard
        else
          Rails.logger.debug @user.errors.full_messages
          render :new
        end
      else
        @user.errors.add(:base, "Developer verification failed.")
        render :new
      end
    else
      if @user.save
        redirect_to root_path, notice: "Signed up successfully." # Redirect to home or another page for regular users
      else
        Rails.logger.debug @user.errors.full_messages
        render :new
      end
    end
  end

  private

  def verify_developer(code)
    Developer.exists?(verification_code: code) # Checks if the developer exists with that code
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :developer, :verification_code)
  end
end
