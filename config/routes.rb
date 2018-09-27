Rails.application.routes.draw do
  use_doorkeeper
  devise_for :user, controllers: { omniauth_callbacks: 'omniauth_callbacks'}

  resources :questions
  resources :answers
  resources :votes
  resources :comments
  resources :subscribe_notifications

  root to: 'questions#index'

  namespace :api do
    namespace :v1 do
      resources :authenticate do
        get :application_profiles, on: :collection
        get :profile, on: :collection
      end

      resources :questions do
        resources :answers
      end
    end
  end
end
