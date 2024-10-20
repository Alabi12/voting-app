class ApplicationController < ActionController::Base
  # After sign in redirection
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_admin_dashboard_path  # Corrected path
    elsif resource.developer?
      developer_dashboard_path
    else
      positions_path  # Or any other path for regular users
    end
  end

  # After sign out redirection
  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end
end
