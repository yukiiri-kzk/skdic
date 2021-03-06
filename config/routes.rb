Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
    
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update, :destroy] do
    member do
      get :profile_show
      get :profile_edit
      put :profile_update
      patch :profile_update
    end
  end
  
  resources :items, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      post :completed
      post :incomplete
    end
  end
  
  resources :chatrooms, only: [:index, :show, :create]
  resources :other_chatrooms, only: [:index]
  resources :messages, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
