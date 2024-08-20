Rails.application.routes.draw do
  
  # Admin 名前空間のルート
  namespace :admin do
    # Dashboards コントローラのindexアクション
    get 'dashboards', to: 'dashboards#index'
    
    # PostComments, Posts, Users, TimelineItems のルーティング
    resources :post_comments, only: [:index, :destroy]
    resources :posts, only: [:index, :destroy]
    resources :users, only: [:show, :destroy]
    resources :timeline_items, only: [:new, :create]
  end

  devise_for :users, controllers: {
      registrations: "users/registrations",
      sessions: 'users/sessions'
  }

  # Devise の管理者用ルーティング
  devise_for :admins, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }


  scope module: :public do

    get 'users/:id', to: 'users#show', as: 'user_my_page'
    root to: "homes#top"
    get "homes/about", to: "homes#about"
    get 'tags/:name', to: 'tags#show', as: :tag

    resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
      collection do
        get 'drafts', to: 'posts#drafts', as: 'drafts'
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
    
    resource :map, only: [:show] 
    
    resources :groups do
     get "join" => "groups#join"
    end
    
    get "search" => "searches#search"
  end
end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

