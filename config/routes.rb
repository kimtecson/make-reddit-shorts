Rails.application.routes.draw do
  # Error handling routes
  get 'errors/not_found'
  get 'errors/internal_server_error'
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # Devise routes
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Health check route
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Static pages
  get '/tos', to: 'pages#tos'
  get '/privacy', to: 'pages#privacy'
  get '/pricing', to: 'pages#pricing'
  get '/about', to: 'pages#about'
  root to: 'pages#home'
  
  # Feedback route
  post 'send_feedback', to: 'pages#send_feedback'

  # Newsletter subscribers
  resources :newsletter_subscribers, only: [:new, :create, :destroy]
  get 'unsubscribe/:id', to: 'newsletter_subscribers#unsubscribe', as: 'unsubscribe'

  # Reddit posts
  get 'reddit_post', to: 'reddit_posts#show'

  # Outputs and nested schedules
  resources :outputs, only: [:index, :show, :new, :create, :destroy] do
    member do
      get :progress   # Job progress tracking
      get :video_url  # Fetch video URL
    end
    resources :schedules, only: [:create]
  end

  # Schedules and sources
  resources :schedules, only: [:index, :destroy]
  resources :sources, only: [:new, :create]
end
