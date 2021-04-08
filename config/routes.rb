Rails.application.routes.draw do
  get 'order/shipping'
  get 'order/payment'
  get 'order/summary'
  get 'order/create'
  get 'order/index'
  get 'order/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products, only: %i[index show]
  resources :categories, only: %i[index]
  resources :cart, only: %i[create destroy index]
  # get 'products/show'
  root to: "products#index"
end
