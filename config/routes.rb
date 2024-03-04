Rails.application.routes.draw do
  get 'events/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :pages, only: [:home] # Assuming you have a PagesController with a home action
  resources :events, only: [:new, :create, :index, :edit, :update, :destroy, :show]




  resources :users, only: [:show, :edit, :update] do
    resource :profile, only: [:edit, :update] # Nested resource for user profiles
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end






# Define custom routes for event categories
# get '/events/dashboard', to: 'events#dashboard', as: 'events_dashboard'
#get 'events/draft', to: 'events#draft', as: 'events_draft'
#get 'events/to_be_modified', to: 'events#to_be_modified', as: 'events_to_be_modified'
#get 'events/under_review', to: 'events#under_review', as: 'events_under_review'
#get 'events/published', to: 'events#published', as: 'events_published'
#get 'events/cancelled', to: 'events#cancelled', as: 'events_cancelled'
#get 'events/archived', to: 'events#archived', as: 'events_archived'
