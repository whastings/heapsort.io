WebDevBookmarks::Application.routes.draw do
  root to: 'pages#home'

  resources :sessions, only: [:create]
  resources :users, only: [:create]
  resources :resources, only: [:index, :show, :create]
  resources :categories, only: [:show]

  get '/signup' => 'users#new'
  delete '/signout' => 'sessions#destroy'
  get '/signin' => 'sessions#new'

  get '/add-resource' => 'resources#new', as: :add_resource

  namespace 'api', :defaults => { :format => :json } do
    resources :resources, only: [:index, :show]
    resources :categories, only: [:show] do
      resources :resources, only: [:index]
    end
  end

end
