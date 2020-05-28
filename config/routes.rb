Rails.application.routes.draw do
  root 'home#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  resources :articles
end
