Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :home do
  end

  resources :users do
    collection do
      get :profile
      get 'get_ticket_by_id/:id', action: :get_ticket_by_id
    end
  end

end
