Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: :show do
    resources :nicknames, only: [:create, :update, :destroy]
  end

  resources :schemes, only: [:new, :create, :show] do
    resources :invitations, controller: :scheme_invitations, only: :create
    resources :polls, only: [:create, :destroy] do
      post 'vote' => 'poll_responses#create'
    end
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  get   '/my'              => 'dashboard#show'
  get   '/settings'        => 'settings#edit'
  patch '/update_settings' => 'settings#update'


  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
