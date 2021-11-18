Rails.application.routes.draw do
  get 'bookings/index'
  devise_for :users
  root to: 'pages#home'
  resources :users, only: %i[index show] do
    resources :bookings, only: %i[index create update new]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
