Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root 'home#index'

  resources :home do
  end

  resources :users do
    collection do
      get :profile
      get 'get_ticket_by_id/:id', action: :get_ticket_by_id
      get 'get_tickets', action: :get_tickets
      resources :categories do
      end
      resources :actions, as: :action_messages do
        get '/reports', action: :actions_report
      end
      resources :reports do
      end
    end
  end

end
