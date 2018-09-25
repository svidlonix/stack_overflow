Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'omniauth_callbacks'}

  resources :questions
  resources :answers
  resources :votes
  resources :comments

  root to: 'questions#index'
end
