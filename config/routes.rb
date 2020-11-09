Rails.application.routes.draw do
  get 'user/new'
  get 'welcome/index'
  resources :articles

  get '/signup', to: 'users#new'
  resources :users, except: [:new]

  root 'welcome#index'
end
