MolySite::Application.routes.draw do



  resources :locations


  resources :events


  # Temp Static Homepage
  root :to => 'home#index'

  # Devise Routes
  devise_for :users, :skip => [:sessions, :registrations]
  as :user do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    delete '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
    end
  end
  
  # Groups
  resources :groups, :only => [:show, :edit, :update]

  # Dashboard
  namespace :dashboard do
    get '', to: 'panel#index', as: '/'
  end

end
