Rails.application.routes.draw do
  devise_for :users

  root to: "users#index"
  resources :users do
    resources :contacts
    resources :groups do
      put :modify_status, on: :member
    end
    get :new_admins, on: :collection
    put :mark_as_admin, on: :member
  end
  resources :connections do
    get :check_info, on: :collection
    post :add_multiple, on: :collection
  end
  resources :domains do
    post :set, on: :member
  end
end
