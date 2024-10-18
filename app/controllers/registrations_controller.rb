# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_action :restrict_access_to_developers, only: [:new, :create]

  private

  def restrict_access_to_developers
    unless current_user&.developer?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
