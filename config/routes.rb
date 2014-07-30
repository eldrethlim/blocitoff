Rails.application.routes.draw do
  get 'tasks/index'

  devise_for :users
  resources :tasks do
    member do
      post 'complete'
    end
  end

  #Home Page
  root to: "welcome#index"
end