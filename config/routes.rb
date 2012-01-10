Tricklr::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get 'sign_in', :to => 'users/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  end

  match 'help', :to => 'pages#help'

  match 'published', :to => 'statuses#published'

  resources :statuses do
    collection do
      put :sort
    end
  end
  resources :settings

  root :to => "pages#index"

  mount Resque::Server.new, :at => "/resque"

end
