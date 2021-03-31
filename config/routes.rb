Rails.application.routes.draw do
  resources :products, only: %i[index show]

  # get 'products/index'
  # get 'products/show'
  # root to: "home#index"
end
