Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
  
  scope module: :public do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  get 'users/:id', to: 'users#show', as: 'user_my_page'
  
  root to: "homes#top" 
  get "homes/about", to: "homes#about"
  
  resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
   resource :favorite, only: [:create, :destroy]
   resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index]
end 
end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

