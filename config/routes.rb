Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'users#profile'

  resources :users do
    collection do
      get :profile, path: '/categorize'
      get 'get_ticket_by_id/:id', action: :get_ticket_by_id
      get 'get_tickets', action: :get_tickets
      post 'recive_category', action: :recive_category
      post 'receive_report', action: :receive_report
      get 'report_confirmation', action: :report_confirmation
      get 'welcome_categorization', action: :welcome_categorization
      resources :categories do
      end
      resources :actions, as: :action_messages do
        get '/reports', action: :actions_report
      end
    end
  end
  resources :reports do
  end
end
