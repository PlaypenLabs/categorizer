Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :home do
  end

  resources :users do
    collection do
      get :profile
      get 'get_ticket_by_id/:id', action: :get_ticket_by_id
      post '/report', action: :report
      resources :categories do
      end
      resources :actions, as: :action_messages do
      end
      resources :reports do
      end
    end
  end

end
