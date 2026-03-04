require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "up" => "rails/health#show", as: :rails_health_check

  authenticate :admin_user do
    mount Sidekiq::Web => "/sidekiq"
  end
  #devise
  devise_for :users
  resources :users, only: [:show] 
  resources :messages, only: [:create]
  
  root "books#index"
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  resources :books do
    member do
      post "buy"
      get :purchased
    end
  end

  # Cart routes
  resource :cart, only: [:show] # 'resource' (singular) creates /cart (no ID needed)

  # Line Item routes (for adding/removing items)
  resources :line_items, only: [:create, :destroy, :update]
end
