Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  # Admin routes
  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: 'dashboard'
    resources :developers, only: [:new, :create] # Ensure this line is included
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
