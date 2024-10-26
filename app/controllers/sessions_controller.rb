class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path  # Correct path to admin dashboard
    elsif resource.developer?
      developer_dashboard_path  # Ensure this route exists
    else
      positions_path  # For regular users (voters)
    end
  end
end
