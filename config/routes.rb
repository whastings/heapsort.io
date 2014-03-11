WebDevBookmarks::Application.routes.draw do
  root to: 'pages#home'

  resources :sessions, only: [:create]
  resources :users, only: [:create]
  resources :bookmarks, only: [:index, :show, :create]
  resources :categories, only: [:show]

  get '/signup' => 'users#new'
  delete '/signout' => 'sessions#destroy'
  get '/signin' => 'sessions#new'

  get '/add-bookmark' => 'bookmarks#new', as: :add_bookmark

  namespace 'api', :defaults => { :format => :json } do
    resources :bookmarks, only: [:index, :show]
  end

end
