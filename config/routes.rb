Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }

  get 'developer_dashboard', to: 'developers#dashboard', as: 'developer_dashboard'
  
  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: 'dashboard'
    # Add a route for the developer dashboard
    resources :candidates, only: [:index, :new, :create, :edit, :update, :destroy, :show]
    resources :developers, only: [:new, :create]
    resources :voters
    resources :positions
    get 'votes_summary', to: 'votes#summary'

    # Custom route for resetting votes
    get 'reset_votes', to: 'votes#reset_votes', as: 'reset_votes'
  end

  resources :positions, only: [:index, :show] do
    resources :candidates do
      member do
        post 'vote', to: 'votes#vote'
      end
    end
  end
end
