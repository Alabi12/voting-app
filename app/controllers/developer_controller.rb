class DeveloperController < ApplicationController
  before_action :authenticate_developer!
  before_action :restrict_signup_to_developers, only: [:new, :create]
  before_action :restrict_signup_to_non_users, only: [:new, :create]

  def authenticate_developer!
    unless current_user&.developer?
      flash[:alert] = "You must be a developer to access this page."
      redirect_to root_path
    end
  end

  def restrict_signup_to_developers
    if current_user && !current_user.developer?
      redirect_to root_path, alert: "Only developers can sign up!"
    end
  end

  def restrict_signup_to_non_users
    if current_user && (current_user.admin? || current_user.voter?)
      redirect_to root_path, alert: "You are not allowed to access the signup page."
    end
  end
end

