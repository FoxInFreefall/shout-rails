Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  namespace :api, :defaults => { :format => :json } do

    resources :projects, only: [:create, :destroy] do
      resources :tasks, only: [:create, :update]
    end

    resources :users do
      resources :invitations, only: [:create]
    end

    devise_scope :user do
      resources :sessions, only: [:create]
    end

  end

  root to:'admin/dashboard#index'

end
