Rails.application.routes.draw do
   root to: "homes#top"  
   devise_for :users
   
  resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  resources :users, only: [:show, :edit, :update, :index]

  get 'homes/about', to: 'homes#about'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

