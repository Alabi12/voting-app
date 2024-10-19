class ApplicationController < ActionController::Base
  # After sign in redirection
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    elsif resource.developer?
      developer_dashboard_path
    else
      positions_path  # Redirect voters to the voting page
    end
  end

  # After sign out redirection
  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end
end
