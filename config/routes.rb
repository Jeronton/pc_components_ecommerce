Rails.application.routes.draw do
  devise_for :users

  get "checkout/shipping"
  get "checkout/payment"
  post "checkout/apply_shipping"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products, only: %i[index show]
  resources :categories, only: %i[index]
  resources :cart, only: %i[create destroy index]
  resources :orders, only: %i[index show create]
  resources :customers, only: %i[show new create]

  # get 'products/show'
  root to: "products#index"
end
