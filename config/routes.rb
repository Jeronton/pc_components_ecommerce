Rails.application.routes.draw do
  resources :products, only: %i[index show]
  resources :categories, only: %i[index]

  # get 'products/index'
  # get 'products/show'
  # root to: "home#index"
end
