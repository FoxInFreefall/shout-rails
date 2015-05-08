Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  namespace :api, :defaults => { :format => :json } do

    resources :projects, only: [:create, :destroy] do
      resources :tasks, only: [:create, :show] do
        resources :assignments, only: [:create, :show]
        delete '/assignments/:user_id', to: 'assignments#destroy'
      end
      resources :invitations, only: [:create, :show]
      delete '/collaboration', to: 'collaborations#destroy'
      put '/accept', to: 'invitations#update'
      delete '/decline', to: 'invitations#destroy'
    end

    resources :users
    resources :invitations, only: [:index]

    devise_scope :user do
      resources :sessions, only: [:create]
    end

  end

  root to:'admin/dashboard#index'

end
