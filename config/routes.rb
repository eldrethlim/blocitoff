Rails.application.routes.draw do
  get 'tasks/index'

  devise_for :users
  resources :tasks do
    member do
      post 'complete'
      post 'incomplete'
    end
  end

  namespace :api do
    resources :users do
      resources :tasks
    end
  end

  get '/users/sign_in' => redirect('/')

  #Home Page
  root to: "welcome#index"
end