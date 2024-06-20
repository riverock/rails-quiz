Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]
  root to: 'people#index'

  namespace :api do
    namespace :v1 do
      resources :people
      # get 'people', to: '/people#index', defaults: { format: 'json' }
      get 'companies', to: '/companies#index', defaults: { format: 'json' }
      post 'companies', to: '/companies#create', defaults: { format: 'json' }
      # resources :companies, only: [:index]
    end
  end
end
