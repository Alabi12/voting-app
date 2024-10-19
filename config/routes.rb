Rails.application.routes.draw do
  get 'render/index'
  devise_for :users, controllers: { registrations: 'registrations' }

  get 'developer/dashboard', to: 'developers#dashboard', as: :developer_dashboard

  # Admin routes
  namespace :admin do
    resources :developers, only: [:new, :create]
    get 'dashboard', to: 'dashboard#index'  # Removed the 'as' option
    # get 'dashboard', to: 'dashboard#index', as: 'dashboard'
    resources :voters
    resources :positions
    resources :candidates
    get 'votes_summary', to: 'votes#summary'
  end

  # Voting routes for regular users
  resources :positions, only: [:index, :show]

  # Root route
  root 'home#index'
end
