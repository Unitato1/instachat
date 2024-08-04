Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks',
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users
  resources :posts
  resources :users_followers, only: [:create, :destroy, :update]
  resources :likes, only: [:create, :destroy, :update]
  resources :comments, only: [:create, :destroy, :update, :edit]
  # Defines the root path route ("/")
  root "posts#index"
end
