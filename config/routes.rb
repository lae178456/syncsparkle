Rails.application.routes.draw do
  get 'events/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :pages, only: [:home] # Assuming you have a PagesController with a home action
  resources :events, only: [:new, :create, :index, :edit, :update, :destroy, :show]
    #publish method sends a POST request to the Eventbrite API endpoint to publish the event specified by its ID
    post 'events/:id/publish', to: 'events#publish', as: 'publish_event'




  resources :users, only: [:show, :edit, :update] do
    resource :profile, only: [:edit, :update] # Nested resource for user profiles
  end

  post 'oauth/', to:'oauths#receive'
  get  'oauth/', to:'oauths#show'

  get '/invite_page', to: 'pages#invite_page', as: :invite_page

  resources :guests, only: [:new, :create, :index, :edit, :update, :destroy]

  #post '/send_invitations', to: 'invitations#send_invitations', as: :send_invitations

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end




#<%= link_to 'Create New Event', new_event_path %>
#<%= link_to 'Publish Event', publish_event_path(@event.id), method: :post, data: { confirm: 'Are you sure you want to publish this event?' } %>


# Define custom routes for event categories
# get '/events/dashboard', to: 'events#dashboard', as: 'events_dashboard'
#get 'events/draft', to: 'events#draft', as: 'events_draft'
#get 'events/to_be_modified', to: 'events#to_be_modified', as: 'events_to_be_modified'
#get 'events/under_review', to: 'events#under_review', as: 'events_under_review'
#get 'events/published', to: 'events#published', as: 'events_published'
#get 'events/cancelled', to: 'events#cancelled', as: 'events_cancelled'
#get 'events/archived', to: 'events#archived', as: 'events_archived'
