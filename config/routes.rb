Rails.application.routes.draw do
  get 'votes/summary'
  get 'positions/index'
  get 'positions/show'
  resources :positions, only: [:index, :show] do
    resources :candidates, only: :show do
      post 'vote', on: :member
    end
  end
  get 'summary', to: 'votes#summary'
  root 'home#index' 
end
