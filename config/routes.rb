Rails.application.routes.draw do
  root 'posts#index'

  get("/users/:id/change_password", to: "users#change_password")
  patch("/users/:id", to: "users#update", as: :new_password)
  resources :users, only: [:new, :create, :edit, :update]

  resource :session, only: [:new,:create, :destroy]

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end


end
