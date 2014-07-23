Rails.application.routes.draw do
  get 'tasks/index'

  devise_for :users

  #Home Page
  root to: "welcome#index"
end