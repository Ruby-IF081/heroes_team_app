Rails.application.routes.draw do
<<<<<<< 45233752c73927c075ff3519ae264495bcc16baa
  devise_for :users

  namespace :account do
    resources :pages, only: %i[show index]
  end
=======
  get  '/add_tenant',  to: 'tenants#new'
  post '/add_tenant',  to: 'tenants#create'
  resources :tenant
>>>>>>> Refactor after reviewing
end
