Prelaunchr::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "users#new"

  resources :users do
    collection do
      get :faq
      get :jobs
      get :partner
      get :policy
      get :presskit
      get :terms
    end
  end

  match 'refer-a-friend' => 'users#refer'
  
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  match 'venues/faq' => 'venues#faq'
  match 'venues/index' => 'venues#index'
end
