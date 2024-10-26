Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  
  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: 'dashboard' # This creates admin_dashboard_path
    resources :candidates, only: [:index, :new, :create, :edit, :update, :destroy, :show]
    get 'dashboard', to: 'dashboard#index', as: 'admin_dashboard' # Define the admin dashb
    resources :developers, only: [:new, :create]
    resources :voters
    resources :positions
    get 'votes_summary', to: 'votes#summary'
  end

  resources :positions do
    resources :candidates do
      member do
        post 'vote', to: 'votes#vote', as: 'vote'
      end
    end
  end

  root 'home#index'
end
