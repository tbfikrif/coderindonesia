Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :categories
      resources :articles
      resources :videos
      resources :schedules
      get '/dashboards', to: 'dashboards#list'
    end
  end
end
