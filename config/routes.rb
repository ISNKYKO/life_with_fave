Rails.application.routes.draw do
  
  namespace :admin do
    get 'posts/index'
    get 'posts/destroy'
  end

  devise_for :admins, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy, :show]
    resources :timeline_items, only: [:new, :create]
    resources :posts, only: [:index, :destroy]
  end

  scope module: :public do
    devise_for :users, controllers: {
      registrations: "users/registrations"
    }

    get 'users/:id', to: 'users#show', as: 'user_my_page'
    root to: "homes#top"
    get "homes/about", to: "homes#about"
    get 'tags/:name', to: 'tags#show', as: :tag

    resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
      collection do
        get :draft
        post :save_draft
        get :drafts
      end

      resources :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

    resources :users, only: [:show, :edit, :update, :index] do
      member do
        get :following, :followers
      end
    end

    resources :relationships, only: [:create, :destroy]
  end
end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

