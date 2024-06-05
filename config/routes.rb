Rails.application.routes.draw do
  namespace :v2 do
    resources :articles, only: [:index, :show]
    resources :artists, only: [:index, :show]
    resources :artworks, only: [:index, :show]
    resources :exhibits, only: [:index, :show]
    resources :galleries, only: [:index, :show]
    resources :homepage, only: [:index]

    root to: 'homepage#index'
  end

  resources :artwork_modals do
    get 'show_modal', on: :collection
    get 'show_sidemodal', on: :collection
    get 'close_modal', on: :collection
    get 'close_sidemodal', on: :collection
  end

  resources :neoma_mailers do
    post 'inquire', on: :collection
    post 'add_to_mailinglist', on: :collection
  end

  Spina::Engine.routes.draw do
    namespace :admin, path: Spina.config.backend_path do
      resources :mailinglists
      resources :mails
    end
  end

  mount Spina::Engine => '/'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  #
end
