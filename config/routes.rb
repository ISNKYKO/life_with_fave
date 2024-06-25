Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top" 
  get "homes/about", to: "homes#about"
  resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
   resource :favorite, only: [:create, :destroy]
   resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index]
end  

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

