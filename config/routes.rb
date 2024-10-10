Rails.application.routes.draw do
  resources :positions do
    resources :candidates do
      post 'vote', to: 'votes#vote', as: 'vote'  # This defines the voting route
    end
  end

  get 'votes/summary', to: 'votes#summary', as: 'summary'
  root 'home#index'
end
