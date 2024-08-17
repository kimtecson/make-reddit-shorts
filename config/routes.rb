Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'reddit_post', to: 'reddit_posts#show'
  get '/tos', to: 'pages#tos'
  get '/privacy', to: 'pages#privacy'
  get '/pricing', to: 'pages#pricing'
  root to: "pages#home"
  post "send_feedback" => "pages#send_feedback"
  # Defines the root path route ("/")
  # root "posts#index"
  resources :outputs, only: [:index, :show, :new, :create] do
    resources :schedules, only: [:create]
  end
  resources :outputs, only: [:destroy]
  resources :schedules, only: [:index, :destroy]
  resources :sources, only: [:create, :new]
end
