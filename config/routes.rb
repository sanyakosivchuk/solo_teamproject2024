Rails.application.routes.draw do
  devise_for :users

  resource :user, only: [:edit, :update]
  resources :categories

  resources :blogs do
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
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
