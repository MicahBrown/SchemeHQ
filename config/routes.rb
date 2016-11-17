Rails.application.routes.draw do
  resources :discussions, only: [:new, :create, :show] do
    resources :invitations, controller: :discussion_invitations, only: :create
    resources :polls, only: [:create, :destroy] do
      post 'vote' => 'poll_responses#create'
    end
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  get   '/settings'        => 'settings#edit'
  patch '/update_settings' => 'settings#update'


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
