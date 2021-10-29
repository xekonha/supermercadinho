Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :products, only: %i[index show new create edit update destroy] do
    collection do
      get :category
    end
  end
  resources :orders, only: %i[index show new create edit update destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
