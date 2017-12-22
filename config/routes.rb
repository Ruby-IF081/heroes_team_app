Rails.application.routes.draw do
  devise_for :users
  root 'account/pages#index'

  namespace :account do
    resources :pages, only: %i[show index]
  end
end
