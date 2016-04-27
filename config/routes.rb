Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :home do
  end

  resources :users do
    collection do
      get :profile
    end
  end

end
