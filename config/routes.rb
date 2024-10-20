Rails.application.routes.draw do
  get 'render/index'
  devise_for :users, controllers: { registrations: 'registrations' }

  # Admin routes
  namespace :admin do
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
      post 'vote', to: 'votes#vote'  # Ensure this route exists
    end
  end

  # Root route
  root 'home#index'
end
