Rails.application.routes.draw do
  namespace :admin do
    get 'candidates/new'
    get 'candidates/create'
  end
  # Devise routes for user authentication
  devise_for :users

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
      
      # Admin routes for managing candidates
      resources :candidates, only: [:new, :create, :index]  # Admin can create and list candidates
    end
  end

  # Root path for the home page
  root 'home#index'
end
