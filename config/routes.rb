Rails.application.routes.draw do
  devise_for :users
  resources :questions
  resources :answers
  resources :votes
  resources :comments

  root to: 'questions#index'
end
