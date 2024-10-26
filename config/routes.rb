Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  # get 'admin/dashboard', to: 'admin/dashboard#show', as: 'admin_dashboard'

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'  # This creates admin_dashboard_path
    resources :candidates, only: [:index, :new, :show, :edit, :update, :destroy]
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
