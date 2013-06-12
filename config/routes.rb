MolySite::Application.routes.draw do

  resources :events
  resources :venues do
    post 'approve'
    resources :sponsors do
      put 'move_up'
      put 'move_down'
    end
  end

  resources :users, only: [:index, :show, :edit, :update]
  resources :groups, only: [:show, :edit, :update]
  resources :memberships, only: [:create, :destroy]
  resources :user_file_uploads, only: [:index]

  match '/about' => 'pages#about'
  match '/dashboard' => 'pages#dashboard'

  # Devise Routes
  devise_for :users, :skip => [:sessions, :registrations, :passwords, :confirmations, :unlocks]
  as :user do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    delete '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get '/logout' => 'devise/sessions#destroy'
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'user',
      path_names: { new: 'sign_up' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
    end
    resource :passwords,      only: [:new, :create, :edit, :update],  path: 'user/password',      controller: 'devise/passwords',       as: 'user_password'
    resource :confirmations,  only: [:new, :create, :show],           path: 'user/confirmation',  controller: 'devise/confirmations',   as: 'user_confirmation'
    resource :unlocks,        only: [:new, :create, :show],           path: 'user/unlock',        controller: 'devise/unlocks',         as: 'user_unlock'
  end

end
