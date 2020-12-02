Rails.application.routes.draw do
  get 'user/new'
  get 'welcome/index'
  resources :articles

  get '/signup', to: 'users#new'
  resources :users, except: [:new]

  root 'welcome#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :categories, except: [:destroy]
end
