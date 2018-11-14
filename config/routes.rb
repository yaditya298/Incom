Rails.application.routes.draw do
  devise_for :users

  root to: "users#index"
  resources :users do
    resources :contacts
    resources :groups
  end
  resources :connections do
    get :check_info, on: :collection
  end
end
