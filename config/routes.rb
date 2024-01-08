Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :home
  resources :users
  get '/check_email_duplication', to: 'users#check_email_duplication'
  resources :roles
  resources :holidays
  # namespace :admin do
  #   resources :users
  # end
  # namespace :manager do
  #   resources :users
  # end
end
