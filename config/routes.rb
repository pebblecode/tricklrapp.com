Tricklr::Application.routes.draw do

  mount MochaRails::Engine => 'mocha' unless Rails.env.production?

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get 'sign_in', :to => 'users/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  end

  match 'help', :to => 'pages#help'
  match 'unsupported_browser', :to => 'pages#unsupported_browser'

  match 'published', :to => 'statuses#published'

  resources :statuses do
    collection do
      put :sort
    end
    member do
      put :publish
    end
  end
  resources :settings

  root :to => "pages#index"

  mount Resque::Server.new, :at => "/resque"

end
