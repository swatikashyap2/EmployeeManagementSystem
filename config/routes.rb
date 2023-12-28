Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',  registrations: 'users/registrations'
  }

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  resources :users
  resources :roles
  namespace :admin do
    resources :users
  end
  namespace :manager do
    resources :users
  end
  resources :roles
end
