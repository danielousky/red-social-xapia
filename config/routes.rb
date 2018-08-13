Rails.application.routes.draw do
  resources :comments
  root to: 'welcome#index'
  devise_for :users
  resources :users
  resources :visitors
  resources :friendships do
  	member do

      post 'confirmed'
    end
  end

end
