Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :home
  resources :users do
    collection do 
      get :checkemail
    end
  end
   
  resources :roles
  resources :leave_types
  resources :user_leave_types
  resources :leave_requests do
    member do
      post  :leave_approve
      post  :leave_reject
    end
  end

  resources :teams
  resources :policies
  # namespace :admin do
  #   resources :users
  # end
  # namespace :manager do
  #   resources :users
  # end
end
