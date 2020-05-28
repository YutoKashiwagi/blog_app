Rails.application.routes.draw do
  root 'home#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  resources :articles, shallow: true do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
end
