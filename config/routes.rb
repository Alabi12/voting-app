Rails.application.routes.draw do
  devise_for :users

  # Positions and Candidates routes for regular users to vote
  resources :positions do
    resources :candidates do
      post 'vote', to: 'votes#vote', as: 'vote'  # Defines the voting route within candidates
    end
  end

  # Admin-specific routes
  namespace :admin do
    resources :voters, only: [:index, :new, :create]  # Admin can manage voters
  end

  # Vote summary route
  get 'votes/summary', to: 'votes#summary', as: 'summary'

  # Root path
  root 'home#index'
end
