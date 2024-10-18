Rails.application.routes.draw do
  get 'render/index'
  # Devise routes for user authentication
  devise_for :users, controllers: { registrations: 'registrations' }

  authenticated :user, ->(u) { u.developer? } do
    get 'sign_up', to: 'devise/registrations#new'
  end

  get 'developer/dashboard', to: 'developer#index', as: 'developer_dashboard'
  patch 'developer/assign_role/:id', to: 'developer#assign_role', as: 'assign_role'


  # Positions and Candidates routes for regular users to vote
  resources :positions do
    resources :candidates do
      post 'vote', to: 'votes#vote', as: 'vote'  # Defines the voting route within candidates
    end
  end

  # Admin-specific routes, authenticated and restricted to admin users
  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :voters, only: [:index, :new, :create]  # Admin can manage voters

      # Route for viewing the vote summary
      get 'votes/summary', to: 'votes#summary', as: 'votes_summary'  # Admin can view the vote summary
      get 'summary/pdf', to: 'votes#summary_pdf', as: 'summary_pdf' # Route for PDF download
      
      # Admin routes for managing candidates
      resources :candidates, only: [:new, :create, :index]  # Admin can create and list candidates
    end
  end

  # Root path for the home page
  root 'home#index'
end
