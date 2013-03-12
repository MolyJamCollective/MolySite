MolySite::Application.routes.draw do

  # Temp Static Homepage
  root :to => 'home#index'

  # Devise Routes
  devise_for :users, :skip => [:sessions]
  as :user do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    delete '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # Dashboard
  namespace :dashboard do
    get '', to: 'panel#index', as: '/'
  end

end
