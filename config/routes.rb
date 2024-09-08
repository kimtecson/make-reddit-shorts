Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'reddit_post', to: 'reddit_posts#show'
  get '/tos', to: 'pages#tos'
  get '/privacy', to: 'pages#privacy'
  get '/pricing', to: 'pages#pricing'
  get '/about', to: 'pages#about'
  root to: "pages#home"
  post "send_feedback", to: "pages#send_feedback"
  resources :newsletter_subscribers, only: [:new, :create, :destroy]
  get 'unsubscribe/:id', to: "newsletter_subscribers#unsubscribe", as: "unsubscribe"

  # Define routes for outputs
  resources :outputs, only: [:index, :show, :new, :create, :destroy] do
    member do
      get :progress   # New route to track job progress for a specific output
      get :video_url # New route for fetching the video URL
    end
    resources :schedules, only: [:create]
  end

  resources :schedules, only: [:index, :destroy]
  resources :sources, only: [:create, :new]
end
