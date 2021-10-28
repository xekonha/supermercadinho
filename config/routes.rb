Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :products, only: %i[index show new create edit update destroy category]
  resources :orders, only: %i[index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
