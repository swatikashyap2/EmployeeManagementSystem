Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :home do
    member do
      post  :leave_approve
      post  :leave_reject
      post  :cancel
    end
  end
  resources :users do
    collection do 
      get :checkemail
      post :search
    end
    member do
      get :send_password
    end
  end
   
  resources :roles
  resources :leave_types
  resources :user_leave_types
  resources :leave_requests do
    collection do 
      get :checkleavedates
      post :search
    end
    member do
      post  :leave_approve
      post  :leave_reject
      post  :cancel
    end
  end

  resources :teams do
    collection do
      post :search
    end
  end
  resources :policies
  resources :notifications do
    collection do
      get :notification_popup
      post :search
      get :mark_all_read_notification
    end
    member do
      get :read_notification
      get :see_notification
    end
  end
  mount ActionCable.server => '/cable'
  # namespace :admin do
  #   resources :users
  # end
  # namespace :manager do
  #   resources :users
  # end
end
