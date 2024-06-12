Rails.application.routes.draw do
  get 'users/edit'
  get 'users/update'
  devise_for :users

  resource :user, only: [:edit, :update]

  resources :blogs do
    resources :posts, only: [:create, :edit, :update, :destroy]
  end

  devise_scope :user do
    authenticated :user do
      root 'blogs#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
