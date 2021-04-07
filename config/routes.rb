Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products, only: %i[index show]
  resources :categories, only: %i[index]
  resources :cart, only: %i[create destroy index]
  # get 'products/show'
  root to: "products#index"
end
