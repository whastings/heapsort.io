WebDevBookmarks::Application.routes.draw do
  root to: 'pages#home'

  resources :sessions, only: [:create]
  resources :users, only: [:create]

  get '/signup' => 'users#new'
  delete '/signout' => 'sessions#destroy'
  get '/signin' => 'sessions#new'

  get '/add-resource' => 'resources#new', as: :add_resource

  # Routes that Backbone handles:
  get '/categories/:id' => 'pages#home'
  get '/resources/:id' => 'pages#home'
  get '/feed' => 'pages#home'
  get '/favorites' => 'pages#home'
  get '/share-resource' => 'pages#home'

  namespace 'api', :defaults => { :format => :json } do
    get 'feed' => 'resources#feed'
    resources :resources, only: [:create, :show] do
      resources :comments, only: [:create]
      resources :votes, only: [:create]
    end
    resources :categories, only: [:show] do
      resources :resources, only: [:index]
    end
    resources :category_subscriptions, only: [:create, :destroy, :index]
    resources :favorites, only: [:create, :destroy, :index]
    resources :resource_types, only: [:index]
  end

end
