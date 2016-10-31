Rails.application.routes.draw do
  resources :discussions, only: [:new, :create, :show] do
    resources :polls, only: [:create] do
      post 'vote' => 'poll_responses#create'
    end
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
