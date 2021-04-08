Rails.application.routes.draw do
  get "checkout/shipping"
  get "checkout/payment"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products, only: %i[index show]
  resources :categories, only: %i[index]
  resources :cart, only: %i[create destroy index]
  resources :orders, only: %i[index show create]

  # get 'products/show'
  root to: "products#index"
end
