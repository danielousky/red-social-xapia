Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users


  resources :visitors do
    collection do
      get 'dashboard'
    end  
  end

end
