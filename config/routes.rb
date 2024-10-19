Rails.application.routes.draw do
  get 'render/index'
  devise_for :users, controllers: { registrations: 'registrations' }

  # Developer routes
  get 'developer/dashboard', to: 'developers#dashboard', as: :developer_dashboard

  # Admin routes
  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: 'dashboard'  # This creates the helper 'admin_dashboard_path'
    resources :developers, only: [:new, :create]
    get 'dashboard', to: 'dashboard#index', as: :admin_dashboard
    resources :voters
    resources :positions
    resources :candidates
    get 'votes_summary', to: 'votes#summary'
  end

  # Voting routes for regular users
  resources :positions do
    resources :candidates do
      post 'vote', to: 'votes#vote', as: 'vote'  # Define the vote route
    end
  end

  # Root route
  root 'home#index'
end
