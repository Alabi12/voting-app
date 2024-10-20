# app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
  def create
    super do |resource|
      if resource.admin?
        redirect_to admin_dashboard_path and return
      elsif resource.developer?
        redirect_to developer_dashboard_path and return
      else
        # Assuming other users are voters, redirect them to the voting page
        redirect_to positions_path and return
      end
    end
  end
end
